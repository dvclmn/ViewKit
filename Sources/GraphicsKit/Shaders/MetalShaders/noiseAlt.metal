//
//  noiseAlt.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 randomNoise(float2 position, half4 color) {
  float value = fract(sin(dot(dest.coord() / 1000,
                              float2(12.9898, 78.233))) * 43758.5453);
  return half4(value, value, value, color.a);
}
