//
//  crt.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

#include <metal_stdlib>
using namespace metal;

// MARK: - 2. CRT Effects (Lines & Mask)
[[ stitchable ]] half4 crtLines(
                                float2 position,
                                half4 color,
                                float4 bounds,
                                float lineSpacing,
                                float lineIntensity,
                                float phosphorSize,
                                float brightnessBoost
                                ) {
  // A. FIXED SCANLINES (Horizontal)
  // Instead of viewSize.y, we use 'position.y' directly.
  // This makes lines stay the same physical size during resize.
  float scanline = sin(position.y * (6.28318 / lineSpacing));
  
  
  // Normalize sine (-1..1) to a controlled darkening factor
  float scanlineValue = mix(1.0, (scanline + 1.0) * 0.5, lineIntensity);
  
  // B. APERTURE GRILLE (Vertical)
  // Simulates the vertical phosphor strips or shadow mask
  float grille = sin(position.x * (6.28318 / phosphorSize));
  float grilleValue = mix(1.0, (grille + 1.0) * 0.5, lineIntensity * 0.5);
  
  // C. VIGNETTE
  // Subtle darkening of the corners for depth
  float2 uv = position / bounds.zw;
  float vignette = uv.x * uv.y * (1.0 - uv.x) * (1.0 - uv.y);
  vignette = pow(16.0 * vignette, 0.1);
  
  // Combine everything
  half4 result = color;
  half factor = half(scanlineValue * grilleValue * vignette);
  result.rgb *= half3(factor);
  
  return result * brightnessBoost;
}
