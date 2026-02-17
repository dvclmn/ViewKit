//
//  File.swift
//
//
//  Created by Dave Coleman on 30/4/2024.
//

import Foundation
import SwiftUI

//extension ShadowStyle {
//  public static
//}

/// Only used internall by ``ShadowModifier``
struct DepthShadowBaseModifier: ViewModifier {

  var opacity: Double
  var radius: Double
  var distanceY: Double
  var isEnabled: Bool

  func body(content: Content) -> some View {
    content
      .shadow(
        color: .black.opacity(isEnabled ? opacity : 0),
        radius: radius * 0.5,
        x: 0, y: 2
      )
      .shadow(
        color: .black.opacity(isEnabled ? opacity * 0.5 : 0),
        radius: radius * 0.7,
        x: 0, y: max(1, (distanceY / 2))
      )
      .shadow(
        color: .black.opacity(isEnabled ? opacity : 0),
        radius: radius * 2,
        x: 0, y: distanceY
      )

    /// Values from Popup view, which seemed nice, here just in case
//      .shadow(
//        color: .black.opacity(0.2),
//        radius: 40,
//        x: 0, y: 18
//      )
//      .shadow(
//        color: .black.opacity(0.2),
//        radius: 9,
//        x: 0, y: 1
//      )
  }
}
