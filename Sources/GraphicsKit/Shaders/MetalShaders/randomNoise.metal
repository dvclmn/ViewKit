//
//  randomNoise.metal
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// Hash function for more controllable randomness
float hash(float2 p, float time) {
  // Include time in the hash to create more dynamic randomness
  p += float2(sin(time), cos(time)) * 0.1;
  p = fract(p * float2(123.34, 456.21));
  p += dot(p, p + 45.32);
  return fract(p.x * p.y);
}

float smoothNoise(float2 p, float time, float turbulence) {
  float2 i = floor(p);
  float2 f = fract(p);
  
  // More dynamic time-based variation
  float2 randomOffset = float2(
                               
                               sin(time * 5.0 + i.x * 10.0) * turbulence,
                               cos(time * 4.0 + i.y * 10.0) * turbulence
                               );
  
  // Smooth interpolation with added randomness
  float2 u = f * f * (3.0 - 2.0 * f) + randomOffset;
  
  return mix(
             mix(hash(i, time), hash(i + float2(1, 0), time), u.x),
             mix(hash(i + float2(0, 1), time), hash(i + float2(1, 1), time), u.x),
             u.y
             );
}


[[ stitchable ]]
half4 randomNoise(
                  
                  
                  float2 position,
                  SwiftUI::Layer layer,
                  half4 color,
                  float time,
                  float intensity,
                  float grainSize,
                  float animSpeed,
                  float turbulence,
                  float contrast,
                  float colorSaturation
                  ) {
  // Scale position to control grain size
  float2 scaledPos = position / max(grainSize, 0.1);
  
  // Dynamic time-based variation with controllable speed
  float dynamicTime = time * animSpeed;
  
  // Use the same base position and time for all color channels
  float redNoise = smoothNoise(scaledPos * 10.0, dynamicTime, turbulence);
  float greenNoise = smoothNoise(scaledPos * 10.0, dynamicTime, turbulence);
  float blueNoise = smoothNoise(scaledPos * 10.0, dynamicTime, turbulence);
  
  // Contrast adjustment
  redNoise = pow(redNoise, 1.0 / max(contrast, 0.1));
  greenNoise = pow(greenNoise, 1.0 / max(contrast, 0.1));
  blueNoise = pow(blueNoise, 1.0 / max(contrast, 0.1));
  
  // Noise intensity control
  float noiseStrength = intensity * 0.5;
  
  // Chromatic noise with color saturation
  half4 noise = half4(
                      redNoise * noiseStrength,
                      greenNoise * noiseStrength,
                      blueNoise * noiseStrength,
                      1.0
                      );
  
  // Interpolate between grayscale and colored noise based on saturation
  float grayscaleNoise = (noise.r + noise.g + noise.b) / 3.0;
  noise = mix(
              half4(grayscaleNoise, grayscaleNoise, grayscaleNoise, 1.0),
              noise,
              colorSaturation
              );
  
  // Sample original content
  half4 originalColor = layer.sample(position);
  
  // Screen blend mode
  half4 blendedColor = 1.0 - (1.0 - originalColor) * (1.0 - noise);
  
  return blendedColor;
}
