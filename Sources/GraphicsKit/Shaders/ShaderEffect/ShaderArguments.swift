//
//  ShaderArguments.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/7/2026.
//

import SwiftUI

extension ShaderEffect {

  public var arguments: [Shader.Argument] {
    switch self {
      case .chromaticAberration(let strength, let radialStrength, let channelSeparation):
        [
          .boundingRect,
          .float(strength),
          .float(radialStrength),
          .float(channelSeparation),
        ]

      case .fisheye(let origin, let radius, let strength):
        [.boundingRect, .float2(origin), .float(radius), .float(strength)]

      case .glitter(let spread):
        [.boundingRect, .float(spread)]

      case .crtCurvature(let strength):
        [.boundingRect, .float(strength)]

      case .crtLines(let lineSpacing, let lineIntensity, let phosphorSize, let brightness):
        [
          .boundingRect,
          .float(lineSpacing),
          .float(lineIntensity),
          .float(phosphorSize),
          .float(brightness),
        ]

      case .radialBlur(let origin, let strength, let start, let end, let samples):
        [
          .boundingRect,
          .float2(origin),
          .float(strength),
          .float(start),
          .float(end),
          .float(samples),
        ]

      case .ripplePush(let location, let velocity):
        [.float2(location), .float2(velocity)]

      case .psych(let time):
        [.boundingRect, .float(time)]

      case .filmGrain(let time, let size, let intensity, let colour):
        [.float(time), .float(size), .float(intensity), .float(colour)]

      case .checkerboard(let primary, let secondary, let scale, let offset):
        [
          .boundingRect,
          .color(primary.toColour),
          .color(secondary.toColour),
          .float(scale),
          .float2(offset),
        ]
    }
  }
}
