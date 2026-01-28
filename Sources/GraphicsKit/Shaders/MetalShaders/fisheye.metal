//
//  fisheye.metal
//  DrawString
//
//  Created by Dave Coleman on 3/12/2024.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 fisheye(float2 position, float2 viewSize, float strength) {
  // Compute 2D center of the view
  float2 center = viewSize * 0.5;

  // Use the minimum half-dimension for uniform, circular normalization
  // This keeps the fisheye effect centered and circular regardless of aspect ratio
  float2 halfSize = center;
  float radiusScale = min(halfSize.x, halfSize.y);

  // Convert position to normalized coordinates (-1 to 1) using uniform scale
  float2 normalisedPosition = (position - center) / radiusScale;

  // Calculate the distance from center (radius)
  float radius = length(normalisedPosition);

  // Apply barrel distortion
  // r' = r * (1 + k * r^2) where k is the strength parameter
  float distortedRadius = radius * (1.0 + strength * radius * radius);

  // Avoid division by zero at the exact center
  float safeRadius = max(radius, 1e-6);

  // Convert back to original coordinate space
  float2 distortedPosition = normalisedPosition * (distortedRadius / safeRadius);
  return (distortedPosition * radiusScale) + center;
}
