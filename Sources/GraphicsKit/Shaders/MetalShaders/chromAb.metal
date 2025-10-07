//
//  chromAb.metal
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;


[[ stitchable ]]
half4 chromaticAberration(float2 position,
                          SwiftUI::Layer layer,
                          float red,
                          float blue,
                          float strength) {
  
  /// Store the origin colour
  half4 original_color = layer.sample(position);
  
  /// Create a new color variable to store the modified color
  half4 new_color = original_color;
  
  /// we modify the color by shifting the red and blue channels.
  new_color.r = layer.sample(position - float2(red, -red)).r;
  
  /// green is optional, but we can use it to create a more realistic effect.
  new_color.g = layer.sample(position).g;
  
  new_color.b = layer.sample(position - float2(blue, -blue)).b;
  
  /// blend the original color with the new color based on the strength factor.
  half4 blended_color = mix(original_color, new_color, strength);
  
  return blended_color;
}

