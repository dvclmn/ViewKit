//
//  radialBlurAlts.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

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

