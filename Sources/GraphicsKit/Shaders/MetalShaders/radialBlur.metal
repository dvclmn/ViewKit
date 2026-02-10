#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

/// Progressive radial blur shader with zoom blur effect
/// Blurs pixels more intensely as they approach the edges from a central origin point
[[ stitchable ]] half4 radialBlur(
                                  float2 position,
                                  SwiftUI::Layer layer,
                                  float4 bounds,
                                  float2 origin,
                                  float blurStrength,
                                  float falloffStart,
                                  float falloffEnd,
                                  float samples
                                  ) {
  // Get the size of the layer
  float2 size = bounds.zw;
  
  // Normalize position to [0, 1]
  float2 normalizedPos = position / size;

  // Treat `origin` as a normalized offset from the layer's center.
  // The center in normalized coordinates is (0.5, 0.5) regardless of bounds origin.
  float2 normalizedCenter = float2(0.5, 0.5);
  float2 normalizedOrigin = clamp(normalizedCenter + origin, 0.0, 1.0);
  
  // Calculate distance from origin
  float2 delta = normalizedPos - normalizedOrigin;
  float distance = length(delta);
  
  // Calculate blur amount based on distance with customizable falloff
  // falloffStart: distance at which blur begins (0.0 = center, 1.0 = far edge)
  // falloffEnd: distance at which blur reaches maximum (typically > falloffStart)
  float blurAmount = smoothstep(falloffStart, falloffEnd, distance);
  
  // If no blur needed, return original pixel
  if (blurAmount < 0.001) {
    return layer.sample(position);
  }
  
  // Adaptive sample count based on blur amount (performance optimization)
  int actualSamples = int(mix(4.0, samples, blurAmount));
  
  // Direction from origin to current position (for zoom blur)
  float2 direction = delta;
  if (length(direction) > 0.0001) {
    direction = normalize(direction);
  }
  
  // Accumulate color samples
  half4 color = half4(0.0);
  float totalWeight = 0.0;
  
  // Sample along the radial direction (zoom blur)
  for (int i = 0; i < actualSamples; i++) {
    // Calculate offset with gaussian-like distribution
    float t = (float(i) / float(actualSamples - 1)) - 0.5; // -0.5 to 0.5
    
    // Gaussian weight for better quality blur
    float weight = exp(-2.0 * t * t);
    
    // Scale the offset by blur strength and blur amount
    float offset = t * blurStrength * blurAmount;
    
    // Sample position along the radial direction
    float2 samplePos = position + direction * offset * size.x * 0.5;
    
    // Accumulate weighted color
    color += layer.sample(samplePos) * weight;
    totalWeight += weight;
  }
  
  // Normalize by total weight
  color /= totalWeight;
  
  return color;
}

