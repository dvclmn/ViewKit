//
//  noiseAlt.metal
//  ViewKit
//
//  Created by Dave Coleman on 21/1/2026.
//

// Full credit to Jacob Bartlett for these noise shaders
// https://github.com/jacobsapps/metal

#include <metal_stdlib>
using namespace metal;

#include "ShaderHelpers.h"

[[ stitchable ]]
half4 randomNoiseAlt(
                  float2 position,
                  half4 color,
                  float time
                  ) {
  float value = fract(sin(dot(position + time, float2(12.9898, 78.233))) * 43758.5453);
  return half4(value, value, value, 1) * color.a;
}

[[ stitchable ]]
half4 perlinNoise(
                  float2 position,
                  half4 color,
                  float2 size
                  ) {
  float2 st = position / size;
  float2 pos = float2(st * 10);
  float n = noiseAlt(pos);
  return half4(half3(n), 1.0);
}
