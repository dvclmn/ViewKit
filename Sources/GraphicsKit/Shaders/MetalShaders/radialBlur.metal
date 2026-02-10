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
  
  // Normalize position and origin to [0, 1]
  float2 normalizedPos = position / size;
  float2 normalizedOrigin = origin;
  
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

/// Alternative: Circular radial blur (samples in a circular pattern around each pixel)
/// This creates a more traditional blur rather than zoom blur
[[ stitchable ]] half4 radialBlurCircular(
                                          float2 position,
                                          SwiftUI::Layer layer,
                                          float4 bounds,
                                          float2 origin,
                                          float blurStrength,
                                          float falloffStart,
                                          float falloffEnd,
                                          float samples
                                          ) {
  float2 size = bounds.zw;
  float2 normalizedPos = position / size;
  float2 normalizedOrigin = origin;
  
  // Calculate distance from origin
  float distance = length(normalizedPos - normalizedOrigin);
  
  // Calculate blur amount with smooth falloff
  float blurAmount = smoothstep(falloffStart, falloffEnd, distance);
  
  if (blurAmount < 0.001) {
    return layer.sample(position);
  }
  
  // Adaptive sample count
  int actualSamples = int(mix(4.0, samples, blurAmount));
  
  half4 color = half4(0.0);
  float totalWeight = 0.0;
  
  // Sample in a circular/spiral pattern
  float goldenAngle = 2.399963; // Golden angle in radians
  
  for (int i = 0; i < actualSamples; i++) {
    float angle = float(i) * goldenAngle;
    float radius = sqrt(float(i) / float(actualSamples)); // Sqrt for even distribution
    
    // Calculate offset
    float2 offset = float2(cos(angle), sin(angle)) * radius;
    offset *= blurStrength * blurAmount;
    
    // Sample position
    float2 samplePos = position + offset * size.x * 0.5;
    
    // Weight decreases with distance from center
    float weight = 1.0 - radius * 0.5;
    
    color += layer.sample(samplePos) * weight;
    totalWeight += weight;
  }
  
  color /= totalWeight;
  return color;
}

/// High-performance version with fewer samples for real-time interaction
[[ stitchable ]] half4 radialBlurFast(
                                      float2 position,
                                      SwiftUI::Layer layer,
                                      float4 bounds,
                                      float2 origin,
                                      float blurStrength,
                                      float falloffStart,
                                      float falloffEnd
                                      ) {
  float2 size = bounds.zw;
  float2 normalizedPos = position / size;
  float2 normalizedOrigin = origin;
  
  float2 delta = normalizedPos - normalizedOrigin;
  float distance = length(delta);
  
  float blurAmount = smoothstep(falloffStart, falloffEnd, distance);
  
  if (blurAmount < 0.001) {
    return layer.sample(position);
  }
  
  float2 direction = normalize(delta);
  
  // Fixed 8 samples for performance
  const int samples = 8;
  half4 color = half4(0.0);
  
  for (int i = 0; i < samples; i++) {
    float t = (float(i) / float(samples - 1)) - 0.5;
    float weight = exp(-2.0 * t * t);
    float offset = t * blurStrength * blurAmount;
    float2 samplePos = position + direction * offset * size.x * 0.5;
    color += layer.sample(samplePos) * weight;
  }
  
  color /= 4.4; // Approximate normalization for 8 samples
  return color;
}

