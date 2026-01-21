//
//  shader.shader.swift
//  TemplateProject
//
//  Created by Dave Coleman on 30/1/2025.
//

#include <metal_stdlib>
using namespace metal;

#include "ShaderHelpers.h"

[[ stitchable ]]
half4 filmGrain(float2 position,
                half4 color,
                float time,
                float grainSize,
                float grainIntensity,
                float colorfulness) {
  // Normalize position and scale by grain size
  float2 normalizedPos = position / grainSize;
  
  // Get random value based on position and time
  float2 random = randomAlt(normalizedPos + float2(time * 0.1));
  float noise = random.x;
  
  // Generate colored noise
  float3 coloredNoise = float3(
                               randomAlt(normalizedPos + float2(time * 0.11)).x,
                               randomAlt(normalizedPos + float2(time * 0.12)).x,
                               randomAlt(normalizedPos + float2(time * 0.13)).x
                               );
  
  // Mix between monochrome and colored noise
  float3 finalNoise = mix(float3(noise), coloredNoise, colorfulness);
  
  // Apply noise to color
  float3 result = float3(color.rgb) + (finalNoise - 0.5) * grainIntensity;
  
  return half4(half3(result), color.a);
}
