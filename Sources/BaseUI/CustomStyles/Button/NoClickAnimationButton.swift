//
//  NoClickAnimationButton.swift
//  ViewKit
//
//  Created by Dave Coleman on 17/2/2026.
//

import SwiftUI

extension ButtonStyle where Self == NoClickAnimationButton {
//extension PrimitiveButtonStyle where Self == NoClickAnimationButton {
  public static var noClickAnimation: Self { Self() }
  public static func noClickAnimation(isPlain: Bool = false) -> Self {
    Self(isPlain: isPlain)
  }
}

//
public struct NoClickAnimationButton: ButtonStyle {
//public struct NoClickAnimationButton: PrimitiveButtonStyle {
  @Environment(\.isEnabled) private var isEnabled

  let isPlain: Bool

  init(isPlain: Bool = false) {
    self.isPlain = isPlain
  }

  public func makeBody(configuration: Configuration) -> some View {

    configuration.label
//    Button {
//      configuration.trigger()
//    } label: {
//      configuration.label
//    }  // END button
//    
//    .buttonStyle(.plain)
  }
}
