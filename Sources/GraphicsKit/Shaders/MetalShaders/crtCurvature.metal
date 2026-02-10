//
//  crtCurvature.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

#include <metal_stdlib>
using namespace metal;

// MARK: - Enhanced CRT Curvature
// Simulates the barrel distortion of a curved CRT glass front
[[ stitchable ]] float2 crtCurvature(
                                     float2 position,
                                     float4 bounds,
                                     float curvatureAmount,
                                     float zoom
                                     ) {
  float2 viewSize = bounds.zw;
  float2 center = viewSize * 0.5;
  
  // Normalize to -1..1 range
  float2 uv = (position - center) / (viewSize * 0.5);
  
  // Aspect correction
  float aspect = viewSize.x / viewSize.y;
  float2 uvAspect = float2(uv.x * aspect, uv.y);
  
  // Calculate radial distance
  float r2 = dot(uvAspect, uvAspect);
//  float r = sqrt(r2);
  
  // === THE KEY IMPROVEMENT ===
  // Multi-term polynomial distortion for that authentic CRT feel
  // - r^2 term: gentle barrel across the center
  // - r^4 term: accelerates distortion toward edges
  // - r^6 term: really cranks it up at the boundaries
  
  float k1 = curvatureAmount * 0.15;      // Gentle center bulge
  float k2 = curvatureAmount * 0.10;      // Mid-range acceleration
  float k3 = curvatureAmount * 0.05;      // Edge punch
  
//  float edgeFalloff = 2.0; // Higher = sharper edge ramp
//  float distortion = 1.0 + k1 * pow(r2, edgeFalloff * 0.5);
  
  float distortion = 1.0 + k1 * r2 + k2 * r2 * r2 + k3 * r2 * r2 * r2;
  
  // Apply distortion with zoom compensation
  float2 distortedUV = uv * distortion / zoom;
  
  // Convert back to pixel space
  float2 outPos = (distortedUV * (viewSize * 0.5)) + center;
  
  return outPos;
}
