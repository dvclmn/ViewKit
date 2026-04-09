//
//  fisheye.metal
//  DrawString
//
//  Created by Dave Coleman on 3/12/2024.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 fisheye(
                                float2 position,
                                float4 viewBounds,
                                float2 origin,
                                float radius,
                                float strength
                                ) {

  // Use the minimum half-dimension for uniform, circular normalization
//  float2 halfSize = origin;
//  float radiusScale = min(halfSize.x, halfSize.y);
// Use half of the minimum viewport dimension for consistent, screen-filling effect
  float radiusScale = min(viewBounds.z, viewBounds.w) * radius;

  // Convert position to normalized coordinates (-1 to 1) using uniform scale
  float2 p = (position - origin) / radiusScale;

  // Radial distance from origin in normalized space
  float r = length(p);

  // Early out: if outside the unit circle, keep position (pins edges and beyond)
//  if (r >= 1.0) {
//    return position;
//  }

  // Clamp strength to [0, 1] for stability and predictable behaviour
  float t = clamp(strength, 0.0, 1.0);

  // Smoother, boundary-preserving bulge using a shaped smoothstep curve
  // Keep r'(1) = 1 (edges pinned) and r'(0) ~ 0, with a gradual transition.
  // Build an S-curve with adjustable edge falloff steepness.
  // Base smoothstep-like curve in [0,1]
  float s = r * r * (3.0 - 2.0 * r); // cubic smoothstep

  // Optionally sharpen origin while softening edges with a power shaping
  // Higher k => stronger origin bulge but still gentle near edges.
  float k = mix(1.0, 0.5, t); // reduce k slightly as t grows to keep edges gentle
  s = pow(s, k);

  // Blend identity and shaped S-curve; ensures r'(1)=1 and a smooth falloff near the boundary
  float rp = mix(r, s, t);

  // Avoid divide-by-zero at the exact origin
  float safeR = max(r, 1e-6);

  // Direction preserved, new radius applied
  float2 pDistorted = p * (rp / safeR);

  // Optional zoom compensation: keep the boundary exactly at r=1 mapped to itself in pixel space
  // Since we normalized by radiusScale, simply scale back by radiusScale to return to pixel coords.
  return pDistorted * radiusScale + origin;
}
