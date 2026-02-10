//
//  crt.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

#include <metal_stdlib>
using namespace metal;

// Colour effect
// Configurable CRT-style pincushion/barrel distortion with aspect and center control
[[ stitchable ]] float2 crtCurvature(
                                     float2 position,
                                     float4 bounds,
                                     float k1,          // primary radial term (negative for CRT pincushion)
                                     float k2          // secondary term for nuance (usually small magnitude)
                                     ) {
  // float2 center     // distortion center in pixels
  // clamp output to bounds to avoid sampling outside
  bool clampToBounds = true;
  
  // Normalize to -1..1 with aspect correction so distortion is radially symmetric
  float2 viewSize = bounds.zw;
  // Derive center as the midpoint of the view size
  float2 center = viewSize * 0.5;
  float2 uv = (position - center) / viewSize * 2.0; // centered UV in -2..2 range relative to center

  // Apply aspect correction (scale x by aspect so circle stays circle)
  float aspect = viewSize.x / max(1.0, viewSize.y);
  float2 uvAspect = float2(uv.x / aspect, uv.y);

  // Radial distance squared
  float r2 = dot(uvAspect, uvAspect);

  // Radial scale: 1 + k1*r^2 + k2*r^4
  float scale = 1.0 + k1 * r2 + k2 * (r2 * r2);

  // Avoid division by very small scale; clamp to a reasonable minimum
  scale = max(scale, 0.0001);

  // Apply inverse mapping: map distorted screen position back to source
  float2 distorted = uvAspect * scale;

  // Undo aspect correction
  distorted.x *= aspect;

  // Map back to pixel space
  float2 outPos = distorted * 0.5 * viewSize + center;

  if (clampToBounds) {
    outPos = clamp(outPos, float2(0.0, 0.0), viewSize);
  }

  return outPos;
}

// Distortion effect
[[ stitchable ]] half4 crtLines(
                                float2 position,
                                half4 color,
                                float4 bounds,
                                float density
                                ) {
  // 1. Basic Scanlines
  // We use a sine wave based on the Y position to create the dark gaps
  float2 viewSize = bounds.zw;
  float scanlineFrequency = viewSize.y * density; // Adjust for density
  float scanline = 0.8 + 0.2 * sin(position.y * scanlineFrequency);
  
  // 2. Simple Aperture Grille (Vertical lines)
  float grilleFrequency = viewSize.x * 2.0;
  float grille = 0.9 + 0.1 * sin(position.x * grilleFrequency);
  
  // 3. Combine and boost "glow"
  half4 result = color * scanline * grille;
  
  // Subtle brightness boost to compensate for the dark lines
  return result * 1.2;
}

