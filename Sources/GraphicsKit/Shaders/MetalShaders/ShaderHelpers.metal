//
//  ShaderHelpers.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

// Source - https://stackoverflow.com/a
// Posted by jperl, modified by community. See post 'Timeline' for change history
// Retrieved 2026-01-21, License - CC BY-SA 3.0

#include <metal_stdlib>

using namespace metal;

#include "ShaderHelpers.h"

// MARK: - Hashing

// Hash function for more controllable randomness
float hash(float2 p, float time) {
  // Include time in the hash to create more dynamic randomness
  p += float2(sin(time), cos(time)) * 0.1;
  p = fract(p * float2(123.34, 456.21));
  p += dot(p, p + 45.32);
  return fract(p.x * p.y);
}

inline float hash(float2 p) {
  // Use a fixed time or 0.0 to make it stable
  return hash(p, 0.0);
}

inline float hashAlt(float n) { return fract(sin(n) * 43758.5453); }


// MARK: - Random noise
inline float random(float2 st) {
  return fract(sin(dot(st, float2(12.9898, 78.233))) * 43758.5453123);
}

// Pseudo-random number generator
inline float2 randomAlt(float2 p) {
  return fract(sin(float2(dot(p, float2(127.1, 311.7)), dot(p, float2(269.5, 183.3)))) * 43758.5453);
}

inline float smoothNoise(float2 p, float time, float turbulence) {
  float2 i = floor(p);
  float2 f = fract(p);
  
  // More dynamic time-based variation
  float2 randomOffset =
  float2(sin(time * 5.0 + i.x * 10.0) * turbulence, cos(time * 4.0 + i.y * 10.0) * turbulence);
  
  // Smooth interpolation with added randomness
  float2 u = f * f * (3.0 - 2.0 * f) + randomOffset;
  
  return mix(mix(hash(i, time), hash(i + float2(1, 0), time), u.x),
             mix(hash(i + float2(0, 1), time), hash(i + float2(1, 1), time), u.x), u.y);
}

float noiseAlt(float2 st) {
  
  float2 i = floor(st);
  float2 f = fract(st);
  
  float a = random(i);
  float b = random(i + float2(1.0, 0.0));
  float c = random(i + float2(0.0, 1.0));
  float d = random(i + float2(1.0, 1.0));
  
  float2 u = f*f*(3.0-2.0*f);
  
  return mix(a, b, u.x)
  + (c - a) * u.y * (1.0 - u.x)
  + (d - b) * u.x * u.y;
}


// MARK: - Movement

inline float oscillate(float f) { return 0.5 * (sin(f) + 1); }

inline float2 rotate(float2 v, float a) {
  float s = sin(a);
  float c = cos(a);
  float2x2 m = float2x2(c, -s, s, c);
  return m * v;
}
