//
//  shaders.metal
//  AnimationVisualiser
//
//  Created by Dave Coleman on 3/11/2024.
//

#include <metal_stdlib>

using namespace metal;

#include "ShaderHelpers.h"

// position = Current pixel position (automatically provided)
// time = Time since start
// size = View dimensions
// speed = How fast the waves move
// strength = How far pixels are displaced
// frequency = How many waves appear

[[ stitchable ]] float2 complexWave(float2 position, float time, float2 size, float speed, float strength, float frequency) {
  
  // Converts pixel coordinates to `0-1` range
  // Makes the effect scale properly with different view sizes
  float2 normalisedPosition = position / size;
  
  // `speed` controls how fast the waves move
  // Higher values = faster movement
  // Negative values = reverse direction
  float moveAmount = time * speed;
  

  // Adds subtle variation to wave frequency over time
  // Frequency controls wave density
  // Higher values = more waves packed together
  
  // Slowly varies between `0.8` and `1.2`
  float freqVariation = sin(time * 0.1) * 0.2 + 1.0;
  float currentFreq = frequency * freqVariation;
  
  float2 offset = float2(0);
  
  // Primary wave
  //
  // strength controls wave amplitude
  // Higher values = more extreme distortion
  // Creates main wave pattern
  offset.x = sin((normalisedPosition.x + moveAmount) * currentFreq) * strength;
  offset.y = cos((normalisedPosition.y + moveAmount) * currentFreq) * strength;
  
  // Secondary wave
  //
  // Adds complexity to the wave pattern
  // Creates cross-waves at different frequencies
  // Uses `40%` of the main strength
  float secondaryFreq = currentFreq * 0.7;
  float secondaryTime = moveAmount * 1.3;
  offset.x += sin((normalisedPosition.y + secondaryTime) * secondaryFreq) * (strength * 0.4);
  offset.y += cos((normalisedPosition.x + secondaryTime) * secondaryFreq) * (strength * 0.4);
  
  // Strength variation
  // Varies between `0.85` and `1.15`
  float variation = hashAlt(floor(time * 0.5)) * 0.3 + 0.85;
  offset *= variation;
  
  return position + offset;
}

