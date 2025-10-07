//
//  pysch.metal
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]]
half4 psych(
                   float2 position,
                   half4 color,
                   float4 bounds,
                   float time) {
  const float speed = 0.5;
  float slowedTime = time * speed;
  
  float2 uv = (position.xy - 0.5 * bounds.wz) / bounds.w;
  float2 cir = uv * uv + sin(uv.x * 15 + slowedTime) / 15.0
  * sin(uv.y * 7.0 + slowedTime) / 2.0 + uv.x
  * sin(slowedTime) / 16.0 + uv.y * sin(slowedTime) / 16.0;
  float circles = sqrt(abs(cir.x + cir.y * 0.5) * 35.0) * 5.0;
  
  return half4(sin(circles * 1.25 + 2.0), abs(sin(circles - 1.0) - sin(circles)), abs(sin(circles)), 1.0);
}
