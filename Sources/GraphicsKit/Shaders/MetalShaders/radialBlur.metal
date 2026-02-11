#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

static inline float maxDistanceToBounds(float2 originN) {
  // originN is in [0,1]. Compute farthest corner distance in normalised space.
  float2 c0 = float2(0.0, 0.0);
  float2 c1 = float2(1.0, 0.0);
  float2 c2 = float2(0.0, 1.0);
  float2 c3 = float2(1.0, 1.0);
  
  float d0 = length(originN - c0);
  float d1 = length(originN - c1);
  float d2 = length(originN - c2);
  float d3 = length(originN - c3);
  
  return max(max(d0, d1), max(d2, d3));
}

/// Progressive radial blur shader with zoom blur effect
[[ stitchable ]] half4 radialBlur(
                                  float2 position,
                                  SwiftUI::Layer layer,
                                  float4 bounds,
                                  float2 origin,          // still treated as offset from centre in normalised units
                                  float blurStrength,
                                  float falloffCentre,    // 0..1 : where blur is 50%
                                  float falloffWidth,     // 0..1 : transition width (softness)
                                  float samples
                                  ) {
  float2 size = bounds.zw;
  
  // Normalise position to [0,1]
  float2 posN = position / size;
  
  // Treat `origin` as a normalised offset from the layer's centre
  float2 centreN = float2(0.5, 0.5);
  float2 originN = clamp(centreN + origin, 0.0, 1.0);
  
  // Normalised distance (0..1), robust to aspect ratio + origin not centred
  float2 deltaN = posN - originN;
  float dist = length(deltaN);
  float maxDist = max(0.0001, maxDistanceToBounds(originN));
  float distanceN = clamp(dist / maxDist, 0.0, 1.0);
  
  // Convert centre/width to [start,end] in a stable way
  float halfW = max(0.0001, falloffWidth * 0.5);
  float start = clamp(falloffCentre - halfW, 0.0, 1.0);
  float end   = clamp(falloffCentre + halfW, 0.0, 1.0);
  
  // Blur ramps from 0 (inside start) to 1 (outside end)
  float blurAmount = smoothstep(start, end, distanceN);
  
  if (blurAmount < 0.001) {
    return layer.sample(position);
  }
  
  int actualSamples = int(mix(4.0, samples, blurAmount));
  
  // Zoom direction in normalised space
  float2 dirN = deltaN;
  float lenDir = length(dirN);
  dirN = (lenDir > 0.0001) ? (dirN / lenDir) : float2(0.0);
  
  half4 color = half4(0.0);
  float totalWeight = 0.0;
  
  // scale: use the smaller dimension to keep blur "strength" consistent
  float pixelScale = min(size.x, size.y);
  
  for (int i = 0; i < actualSamples; i++) {
    float t = (float(i) / float(max(actualSamples - 1, 1))) - 0.5; // [-0.5, 0.5]
    float weight = exp(-2.0 * t * t);
    
    float offset = t * blurStrength * blurAmount;
    
    // Convert from normalised direction into pixel offset
    float2 samplePos = position + (dirN * offset * pixelScale);
    
    color += layer.sample(samplePos) * weight;
    totalWeight += weight;
  }
  
  color /= max(totalWeight, 0.0001);
  return color;
}
