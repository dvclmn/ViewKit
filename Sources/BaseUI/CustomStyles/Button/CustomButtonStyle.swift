//
//  ButtonStyle.swift
//  Styles
//
//  Created by Dave Coleman on 30/4/2024.
//
//


import Foundation
import SwiftUI

//
extension PrimitiveButtonStyle where Self == BasePlainButton {
  @available(*, deprecated, renamed: "base", message: "Prefer more accurately named 'base'.")
  public static var custom: Self { Self() }
  public static var base: Self { Self() }
}

//
public struct BasePlainButton: PrimitiveButtonStyle {
  //  @Environment(\.strokeConfig) private var strokeConfig
  //  @Environment(\.isInControlGroup) private var isInControlGroup
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.explicitHeight) private var explicitHeight
  @Environment(\.isBackgroundHidden) private var isBackgroundHidden

  public init() {}

  public func makeBody(configuration: Configuration) -> some View {

    Button {
      configuration.trigger()
    } label: {

      configuration.label
        .quickBackground(isEnabled: !isBackgroundHidden)
        //        .fontWeight(.medium)
        .lineLimit(1)
        //        .frame(height: explicitHeight)
        //        .padding(.bottom, 3)
        .opacity(isEnabled ? 1.0 : 0.4)
        .contentShape(Rectangle())
        .labelStyle(.base)
    }  // END button
    .buttonStyle(.plain)
  }
}
