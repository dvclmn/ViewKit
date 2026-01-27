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
                          float2 center,       // center point (usually view center)
                          float redDistance,
                          float redAngle,      // in radians
                          float blueDistance,
                          float blueAngle,     // in radians
                          float radialStrength, // how much the effect increases from center
                          float strength) {
  
  half4 original_color = layer.sample(position);
  half4 new_color = original_color;
  
  // Calculate distance from center (normalized)
//  let centerIf = layer.
//  float2 center = float2(0.5, 0.5); // center of a normalized layer
//  float2 fromCenter = position - center;
  float2 fromCenter = position - center;
  float distanceFromCenter = length(fromCenter);
  
  // Use a cubic falloff for subtle effect near center, stronger near edges
  float radialMultiplier = 1.0 + pow(distanceFromCenter, 1.0) * radialStrength;
  
  // Calculate offset vectors with radial scaling
  float2 redOffset = float2(cos(redAngle), sin(redAngle)) * redDistance * radialMultiplier;
  float2 blueOffset = float2(cos(blueAngle), sin(blueAngle)) * blueDistance * radialMultiplier;
  
  new_color.r = layer.sample(position + redOffset).r;
  new_color.g = layer.sample(position).g;
  new_color.b = layer.sample(position + blueOffset).b;
  
  half4 blended_color = mix(original_color, new_color, strength);
  
  return blended_color;
}


//half4 chromaticAberration(float2 position,
//                          SwiftUI::Layer layer,
//                          float redDistance,
//                          float redAngle,      // in radians
//                          float blueDistance,
//                          float blueAngle,     // in radians
//                          float strength) {
//  
//  // Store the origin colour
//  half4 original_color = layer.sample(position);
//  
//  // Create a new color variable to store the modified color
//  half4 new_color = original_color;
//  
//  // Calculate offset vectors from angle and distance
//  float2 redOffset = float2(cos(redAngle), sin(redAngle)) * redDistance;
//  float2 blueOffset = float2(cos(blueAngle), sin(blueAngle)) * blueDistance;
//  
//  new_color.r = layer.sample(position + redOffset).r;
//  new_color.g = layer.sample(position).g;
//  new_color.b = layer.sample(position + blueOffset).b;
//  
//  half4 blended_color = mix(original_color, new_color, strength);
//  
//  return blended_color;
//}

