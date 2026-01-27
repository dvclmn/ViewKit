//
//  AnimatedShaderModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

import SwiftUI

@available(macOS 14, iOS 17, *)
public struct ShaderModifier: ViewModifier {

  let effect: ShaderEffect
  let maxOffset: CGSize
  let isEnabled: Bool

  public func body(content: Content) -> some View {

    if #available(macOS 15, iOS 18, *) {
      Group {
        switch effect.usageType {

          case .colorEffect:
            content
              .colorEffect(effect.shader, isEnabled: isEnabled)

          case .distortionEffect:
            content
              .distortionEffect(effect.shader, maxSampleOffset: .zero, isEnabled: isEnabled)

          case .layerEffect:
            content
              .layerEffect(effect.shader, maxSampleOffset: .zero, isEnabled: isEnabled)

          default:
            content
        }
      }
      /// Have removed this, as usually this is taken care of externally
      //      .drawingGroup()

    } else {
      content
    }

  }
}

@available(macOS 14, iOS 17, *)
public struct AnimatedShaderModifier: ViewModifier {

  let shader: ShaderEffect
  let arguments: [Shader.Argument]

  public func body(content: Content) -> some View {
    content
      .layerEffect(
        Shader(
          function: ShaderFunction(
            library: ShaderLibrary.bundle(.module),
            name: shader.reference
          ),
          arguments: arguments
        ),
        maxSampleOffset: .zero
      )
      .drawingGroup()
  }
}

@available(macOS 14, iOS 17, *)
extension View {
  public func shaderEffect(
    _ effect: ShaderEffect,
    maxOffset: CGSize = .zero,
    isEnabled: Bool = true
  ) -> some View {
    self.modifier(
      ShaderModifier(
        effect: effect,
        maxOffset: maxOffset,
        isEnabled: isEnabled
      )
    )
  }
  //  public func shaderEffect(_ effect: ShaderEffect, _ args: [Shader.Argument]) -> some View {
  //    self.modifier(AnimatedShaderModifier(shader: effect, arguments: args))
  //  }
}

//public struct WavyBlur: ViewModifier {
//  private let startDate = Date()
//  public func body(content: Content) -> some View {
//    content
//      .overlay {
//        TimelineView(.animation) { _ in
//          Rectangle()
//            .colorEffect(
//              ShaderLibrary.psychodelics(
//                .boundingRect,
//                .float(startDate.timeIntervalSinceNow)
//              )
//            )
//            .scaleEffect(10)
//
//        }
//        //                .blur(radius: 6, opaque: true)
//        .brightness(-0.30)
//        .blendMode(.colorDodge)
//        .hueRotation(Angle(degrees: 90))
//        .opacity(0.2)
//        .saturation(0.7)
//        .allowsHitTesting(false)
//      }  // END overlay
//  }
//}
//
//extension View {
//  public func wavyBlur() -> some View {
//    modifier(WavyBlur())
//  }
//}

//public struct ChromaticAbberation: ViewModifier {
//
//  let redOffset: Float
//  let blueOffset: Float
//  let strength: Float
//  public func body(content: Content) -> some View {
//    content
//      .layerEffect(
//        ShaderLibrary.bundle(.module).chromaticAberration(
//          .float(redOffset),
//          .float(blueOffset),
//          .float(strength)
//        ),
//        maxSampleOffset: .zero
//      )
//      .drawingGroup()
//
//  }
//}
//
//extension View {
//  public func chromaticAberration(
//    redOffset: CGFloat = 0.6,
//    blueOffset: CGFloat = 1.6,
//    strength: CGFloat = 0.3
//  ) -> some View {
//    modifier(
//      ChromaticAbberation(
//        redOffset: Float(redOffset),
//        blueOffset: Float(blueOffset),
//        strength: Float(strength)
//      )
//    )
//  }
//}
