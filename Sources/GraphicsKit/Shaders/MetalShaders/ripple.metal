//
//  ripple.metal
//  DrawString
//
//  Created by Dave Coleman on 3/12/2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[stitchable]] half4 ripple(
                            float2 position,
                            SwiftUI::Layer layer,
                            float2 location,
                            float2 velocity
                            ) {
  
  // Compute the motion vector with a falloff based on distance
  float2 m = -velocity * pow(clamp(1 - length(location - position) / 190, 0.0, 1.0), 2) * 1.5;
  
  half3 c = 0; // Initialize the color accumulator to zero
  
  // Loop to sample colors and accumulate
  for (float i = 0; i < 10; i++) {
    float s = 0.175 + 0.005 * i; // Increasing spread factor
    
    // Accumulate sampled colors from texture a at various offsets
    c += half3(
               layer.sample(position + s * m).r,
               layer.sample(position + (s + 0.025) * m).g,
               layer.sample(position + (s + 0.05) * m).b
               );
  }
  
  // Return the average of the sampled colors with an alpha of 1
  return half4(c / 10, 1);
}
