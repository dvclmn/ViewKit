//
//  crt.metal
//  ViewKit
//
//  Created by Dave Coleman on 10/2/2026.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// MARK: - CRT Signal, Scanlines & Aperture Grille
//
// This is deliberately a layer shader rather than a colour shader. A colour
// shader sees only the already-rendered colour at `position`, which is enough
// to place a mask over a view but cannot turn that view into a lower-resolution
// CRT signal. Here, one layer sample is shared by each virtual CRT cell; the
// scanline and aperture grille then describe how that signal is displayed.
[[ stitchable ]] half4 crtLines(
                                float2 position,
                                SwiftUI::Layer layer,
                                float4 bounds,
                                float lineSpacing,
                                float lineIntensity,
                                float phosphorSize,
                                float brightnessBoost
                                ) {
  float2 layerSize = max(bounds.zw, float2(0.001));
  float2 cellSize = max(
    float2(abs(phosphorSize), abs(lineSpacing)),
    float2(0.5)
  );

  // Quantise the source sample first. `phosphorSize` is the width of one RGB
  // triad, and `lineSpacing` is the height of one scanline period, so these
  // remain independent rather than assuming square source pixels.
  float2 localPosition = position - bounds.xy;
  float2 cellIndex = floor(localPosition / cellSize);
  float2 cellCentre = (cellIndex + 0.5) * cellSize;
  float2 samplePosition = clamp(
    bounds.xy + cellCentre,
    bounds.xy + float2(0.001),
    bounds.xy + layerSize - float2(0.001)
  );
  half4 signal = layer.sample(samplePosition);

  float2 cellUV = fract(localPosition / cellSize);

  // A soft beam is bright at the centre of its scanline and falls away before
  // the next one. This avoids the flat, full-height dark bands of a sine mask.
  float distanceFromBeamCentre = abs(cellUV.y - 0.5) * 2.0;
  float beamProfile = 1.0 - smoothstep(0.35, 1.0, distanceFromBeamCentre);
  float scanline = mix(1.0, beamProfile, clamp(lineIntensity, 0.0, 1.0));

  // An aperture grille has three narrow colour phosphors per triad. A small
  // amount of leakage keeps the effect readable on arbitrary SwiftUI content
  // while still making the phosphor structure visible.
  uint phosphor = min(uint(cellUV.x * 3.0), uint(2));
  half3 phosphorMask;
  switch (phosphor) {
    case 0: phosphorMask = half3(1.0, 0.16, 0.16); break;
    case 1: phosphorMask = half3(0.16, 1.0, 0.16); break;
    default: phosphorMask = half3(0.16, 0.16, 1.0); break;
  }

  half3 displayedSignal = signal.rgb * phosphorMask * half(scanline);
  return half4(displayedSignal * half(brightnessBoost), signal.a);
}
