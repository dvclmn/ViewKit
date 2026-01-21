//
//  Shaders.metal
//  Eucalypt
//
//  Created by Dave Coleman on 21/2/2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

#include "ShaderHelpers.h"

[[ stitchable ]]
half4 timeVaryingColor(float2 position, half4 color, float2 size, float time) {
  return half4(oscillate(2 * time + position.x/size.x),
               oscillate(4 * time + position.y/size.y),
               oscillate(-2 * time + position.x/size.y),
               0.1);
}

[[ stitchable ]]
half4 color(float2 position, half4 color, float2 size, float time) {
  return half4(position.x/size.x, position.y/size.y, position.x/size.y, 1.0);
}
