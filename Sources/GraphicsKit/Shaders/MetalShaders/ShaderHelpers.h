//
//  ShaderMaths.metal
//  ViewKit
//
//  Created by Dave Coleman on 21/1/2026.
//

// Useful info:
// https://stackoverflow.com/questions/39283565/metal-include-or-import-function

#ifndef SDF_HEADERS
#define SDF_HEADERS

float hash(float2 p, float time);
float hash(float2 p);
float hashAlt(float n);

float random(float2 st);
float2 randomAlt(float2 p);
float smoothNoise(float2 p, float time, float turbulence);
float noiseAlt(float2 st);

float oscillate(float f);
float2 rotate(float2 v, float a);
#endif
