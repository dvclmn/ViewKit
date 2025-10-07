//
//  glitter.metal
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]]
half4 glitter(
                  float2 position,
                  SwiftUI::Layer layer,
                  float2 size,
                  float time
                  ) {
  float2 uv = float2(position.x + 20, position.y + 60) / (size.x * 0.006);
  float result = 0.0;
  
  const float greysThreshold = 0.12;
  const float speed = 1.2;
  
  half4 red = layer.sample(uv * 0.9 + float2(time * -speed));
  result += red.r;
  
  half4 green = layer.sample(uv * 1.8 + float2(time * speed));
  result *= green.g;
  
  float alpha = result > greysThreshold ? 0.0 : 1.0;
  
  result = result > greysThreshold ? 1.0 : 0.0;
  
  return half4(result, result, result, alpha);
}


