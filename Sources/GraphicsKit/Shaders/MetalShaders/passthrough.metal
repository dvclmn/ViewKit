//
//  passthrough.metal
//  ViewKit
//
//  Created by Dave Coleman on 5/7/2026.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]]
half4 passthroughColour(float2 position, half4 colour) {
  return colour;
}

[[ stitchable ]]
float2 passthroughDistortion(float2 position) {
  return position;
}

[[ stitchable ]]
half4 passthroughLayer(float2 position, SwiftUI::Layer layer) {
  return layer.sample(position);
}
