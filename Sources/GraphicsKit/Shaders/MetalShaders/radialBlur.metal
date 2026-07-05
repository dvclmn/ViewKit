#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

static inline float normalisedDistanceToBounds(float2 positionN, float2 originN) {
  float2 deltaN = positionN - originN;
  float xLimit = deltaN.x < 0.0 ? originN.x : (1.0 - originN.x);
  float yLimit = deltaN.y < 0.0 ? originN.y : (1.0 - originN.y);
  float2 edgeDistance = max(float2(xLimit, yLimit), float2(0.0001));
  float2 scaledDelta = deltaN / edgeDistance;
  
  return clamp(length(scaledDelta), 0.0, 1.0);
}

/// Progressive radial blur shader with zoom blur effect
[[ stitchable ]] half4 radialBlur(
                                  float2 position,
                                  SwiftUI::Layer layer,
                                  float4 bounds,
                                  float2 origin,          // still treated as offset from centre in normalised units
                                  float blurStrength,
                                  float start,            // 0..1 : where blur begins
                                  float end,              // 0..1 : where blur reaches full strength
                                  float samples
                                  ) {
  float2 size = max(bounds.zw, float2(0.0001));
  float2 boundsOrigin = bounds.xy;
  
  // Normalise position to [0,1] inside the layer bounds.
  float2 posN = (position - boundsOrigin) / size;
  
  // Treat `origin` as a normalised offset from the layer's centre
  float2 centreN = float2(0.5, 0.5);
  float2 originN = clamp(centreN + origin, 0.0, 1.0);
  
  // Normalised distance (0..1), robust to aspect ratio + origin not centred.
  float distanceN = normalisedDistanceToBounds(posN, originN);
  
  float rampStart = clamp(start, 0.0, 1.0);
  float rampEnd = clamp(end, 0.0, 1.0);
  
  // Blur ramps from 0 inside `start` to 1 outside `end`.
  // If the range collapses during animation, use a hard threshold instead of
  // passing equal edges to smoothstep.
  float blurAmount = (rampEnd <= rampStart)
    ? (distanceN >= rampStart ? 1.0 : 0.0)
    : smoothstep(rampStart, rampEnd, distanceN);
  
  if (blurAmount < 0.001) {
    return layer.sample(position);
  }
  
  int actualSamples = int(mix(4.0, samples, blurAmount));
  
  // Zoom direction in pixel space.
  float2 originPosition = boundsOrigin + originN * size;
  float2 direction = position - originPosition;
  float directionLength = length(direction);
  direction = (directionLength > 0.0001) ? (direction / directionLength) : float2(0.0);
  
  half4 color = half4(0.0);
  float totalWeight = 0.0;
  
  // scale: use the smaller dimension to keep blur "strength" consistent
  float pixelScale = min(size.x, size.y);
  
  for (int i = 0; i < actualSamples; i++) {
    float t = (float(i) / float(max(actualSamples - 1, 1))) - 0.5; // [-0.5, 0.5]
    float weight = exp(-2.0 * t * t);
    
    float offset = t * blurStrength * blurAmount;
    
    // Convert the normalised blur distance into a pixel offset.
    float2 samplePos = position + (direction * offset * pixelScale);
    
    color += layer.sample(samplePos) * weight;
    totalWeight += weight;
  }
  
  color /= max(totalWeight, 0.0001);
  return color;
}
