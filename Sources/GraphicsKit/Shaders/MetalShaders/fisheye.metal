//
//  fisheye.metal
//  DrawString
//
//  Created by Dave Coleman on 3/12/2024.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 fisheye(float2 position, float2 size, float strength) {
  // Convert position to normalised coordinates (-1 to 1)
  float2 center = size / 2.0;
  float2 normalisedPosition = (position - center) / center;
  
  // Calculate the distance from center (radius)
  float radius = length(normalisedPosition);
  
  // Apply barrel distortion
  // This formula creates the fisheye effect:
  // r' = r * (1 + k * r^2) where k is the strength parameter
  float distortedRadius = radius * (1.0 + strength * radius * radius);
  
  // Convert back to original coordinate space
  float2 distortedPosition = normalisedPosition * (distortedRadius / radius);
  return (distortedPosition * center) + center;
}
