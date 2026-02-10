//
//  crt.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 crtCurvature(
                                     float2 position,
                                     float4 bounds,
                                     float distortion
                                     ) {
  // Normalize coordinates to -1.0 to 1.0
  float2 viewSize = bounds.zw;
  float2 uv = position / viewSize * 2.0 - 1.0;
  
  // Apply barrel distortion
  float2 offset = uv * (uv.yx * uv.yx) * distortion;
  float2 distortedUV = uv + offset;
  
  // Map back to screen coordinates
  return (distortedUV + 1.0) / 2.0 * viewSize;
}

[[ stitchable ]] half4 crtLines(
                                float2 position,
                                half4 color,
                                float4 bounds
                                ) {
  // 1. Basic Scanlines
  // We use a sine wave based on the Y position to create the dark gaps
  float2 viewSize = bounds.zw;
  float scanlineFrequency = viewSize.y * 1.5; // Adjust for density
  float scanline = 0.8 + 0.2 * sin(position.y * scanlineFrequency);
  
  // 2. Simple Aperture Grille (Vertical lines)
  float grilleFrequency = viewSize.x * 2.0;
  float grille = 0.9 + 0.1 * sin(position.x * grilleFrequency);
  
  // 3. Combine and boost "glow"
  half4 result = color * scanline * grille;
  
  // Subtle brightness boost to compensate for the dark lines
  return result * 1.2;
}
