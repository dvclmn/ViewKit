//
//  crtCurvature.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

#include <metal_stdlib>
using namespace metal;

// MARK: - Enhanced CRT Curvature
// Simulates a classic CRT "barrel" distortion (curved glass front).
//
// Notes on how this works:
// - We remap pixel `position` into centred UV space in the range [-1, 1].
// - We compute a radial distance r^2 in *aspect-corrected* space so the distortion is
//   visually symmetric even when the view isn't square.
// - We apply a multi-term polynomial in r^2 to get a gentle centre bulge and
//   stronger distortion towards the edges.
// - Because barrel distortion pushes coordinates outward, the corners would otherwise
//   map outside the source image, creating "peeling"/gaps at the edges when sampling.
//   To prevent that, we compute the *maximum* distortion factor inside the viewport
//   (at the corners) and divide by it — effectively an automatic zoom-out.
//
// `curvatureAmount` is assumed to be in a small-ish range (e.g. 0..1). Larger values
// will exaggerate the effect. Negative values produce pincushion distortion; for those
// we clamp the auto-zoom to 1.0 because inward warps don't cause sampling gaps.
[[ stitchable ]] float2 crtCurvature(
                                     float2 position,
                                     float4 bounds,
                                     float curvatureAmount
                                     ) {
  float2 viewSize = bounds.zw;
  float2 centre = viewSize * 0.5;
  
  // Normalise to centred UV space: (-1,-1) bottom-left, (1,1) top-right.
  float2 uv = (position - centre) / (viewSize * 0.5);
  
  // Aspect correction for the radial metric (so circles stay circular).
  float aspect = viewSize.x / viewSize.y;
  float2 uvAspect = float2(uv.x * aspect, uv.y);
  
  // r^2 in aspect-corrected space.
  float r2 = dot(uvAspect, uvAspect);
  
  // Polynomial coefficients (tuned by eye).
  // Using r^2 avoids a sqrt and keeps the polynomial stable.
  float k1 = curvatureAmount * 0.15;  // gentle centre bulge
  float k2 = curvatureAmount * 0.10;  // mid-range acceleration
  float k3 = curvatureAmount * 0.05;  // edge punch
  
  // Distortion factor at this fragment.
  float distortion = 1.0 + k1 * r2 + k2 * r2 * r2 + k3 * r2 * r2 * r2;
  
  // === Auto zoom compensation ===
  // The maximum r^2 inside the viewport occurs at the corners where uv = (±1, ±1).
  // With aspect-correction in the metric, r2_max = aspect^2 + 1.
  float r2Max = aspect * aspect + 1.0;
  
  float distortionMax = 1.0
  + k1 * r2Max
  + k2 * r2Max * r2Max
  + k3 * r2Max * r2Max * r2Max;
  
  // For barrel distortion (curvatureAmount > 0), distortionMax >= 1 and we divide by it
  // to keep the warped UVs within [-1, 1] — preventing edge gaps when sampling.
  // For pincushion (curvatureAmount < 0), clamp to 1 to avoid unnecessary zoom-in.
  float autoZoom = max(1.0, distortionMax);
  
  float2 distortedUV = uv * (distortion / autoZoom);
  
  // Convert back to pixel space.
  float2 outPos = (distortedUV * (viewSize * 0.5)) + centre;
  return outPos;
}
