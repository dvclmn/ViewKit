//
//  NoClickAnimationButton.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/2/2026.
//

import SwiftUI

extension PrimitiveButtonStyle where Self == NoClickAnimationButton {
  //  @available(*, deprecated, renamed: "base", message: "Prefer more accurately named 'base'.")
  //  public static var custom: Self { Self() }
  public static var noClickAnimation: Self { Self() }
  public static func noClickAnimation(isPlain: Bool = false) -> Self {
    Self(isPlain: isPlain)
  }
}

//
public struct NoClickAnimationButton: PrimitiveButtonStyle {
  //  @Environment(\.strokeConfig) private var strokeConfig
  //  @Environment(\.isInControlGroup) private var isInControlGroup
  @Environment(\.isEnabled) private var isEnabled
  //  @Environment(\.heightOverride) private var heightOverride
  //  @Environment(\.isBackgroundHidden) private var isBackgroundHidden

  let isPlain: Bool

  init(isPlain: Bool = false) {
    self.isPlain = isPlain
  }

  public func makeBody(configuration: Configuration) -> some View {

    Button {
      configuration.trigger()
    } label: {
      configuration.label
    }  // END button
    //    .buttonStyle(.plain)
  }
}
