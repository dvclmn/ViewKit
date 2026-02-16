//
//  File.swift
//
//
//  Created by Dave Coleman on 30/4/2024.
//

import Foundation
import SwiftUI


public struct LayeredShadow: ViewModifier {

  var opacity: Double
  var radius: Double
  var distanceY: Double
  var isOn: Bool

  public func body(content: Content) -> some View {
    content
      .shadow(color: .black.opacity(isOn ? opacity : 0), radius: radius * 0.5, x: 0, y: 2)
      .shadow(
        color: .black.opacity(isOn ? opacity * 0.5 : 0), radius: radius * 0.7, x: 0,
        y: max(1, (distanceY / 2))
      )
      .shadow(color: .black.opacity(isOn ? opacity : 0), radius: radius * 2, x: 0, y: distanceY)
  }
}


//public struct RoundedShadowModifier: ViewModifier {
//
//  let rounding: CGFloat
//  let backgroundColour: Color
//
//  public init(
//    rounding: CGFloat,
//    backgroundColour: Color
//  ) {
//    self.rounding = rounding
//    self.backgroundColour = backgroundColour
//  }
//
//  public func body(content: Content) -> some View {
//
//    content
//      .background {
//        Rectangle()
//          .fill(.regularMaterial)
//          .fill(backgroundColour.opacity(0.35))
//          .stroke(.white.opacity(0.04), style: .init(lineWidth: 1))
//      }
//    //        .compositingGroup()
//
//  }
//}
//public extension View {
//  func roundedShadow(
//    rounding: CGFloat = Styles.sizeSmall,
//    backgroundColour: Color = .black.opacity(0.8)
//  ) -> some View {
//    self.modifier(
//      RoundedShadowModifier(rounding: rounding, backgroundColour: backgroundColour)
//    )
//  }
//}
//
