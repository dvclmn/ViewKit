//
//  chromAb.metal
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

static inline float normalisedDistanceFromCentreToBounds(float2 position, float4 bounds) {
  float2 size = max(bounds.zw, float2(0.0001));
  float2 positionN = (position - bounds.xy) / size;
  float2 fromCentreN = positionN - float2(0.5, 0.5);
  float2 scaledFromCentre = fromCentreN / float2(0.5, 0.5);

  return clamp(length(scaledFromCentre), 0.0, 1.0);
}

[[ stitchable ]]
half4 chromaticAberration(float2 position,
                          SwiftUI::Layer layer,
                          float4 bounds,
                          float strength,
                          float radialStrength,
                          float channelSeparation)
{
  
  half4 original_color = layer.sample(position);
  half4 new_color = original_color;

  // No separation for the inner 20% of the distance to the edge.
  float deadZone = 0.2;
  float normalisedDist = normalisedDistanceFromCentreToBounds(position, bounds);
  
  if (normalisedDist < deadZone) {
    // No distortion, just return original colour.
    return original_color;
  }
  
  // Only start distortion after deadZone.
  // t is 0 inside dead zone, 1 at the edge.
  float t = clamp((normalisedDist - deadZone) / (1.0 - deadZone), 0.0, 1.0);
  
  float exponent = 2.0;
  
  // Apply algorithm, curve to t for fine control.
  float effectStrength = pow(t, exponent);
  
  float radialMultiplier = 1.0 + effectStrength * radialStrength;
  
  // Keep the current effect as a simple horizontal red/blue split.
  float separation = channelSeparation * radialMultiplier;
  float2 redOffset = float2(separation, 0.0);
  float2 blueOffset = float2(-separation, 0.0);
  
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
