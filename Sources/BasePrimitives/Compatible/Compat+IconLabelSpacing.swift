//
//  Compact+IconLabelSpacing.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/9/2025.
//

import SwiftUI

extension View {
  @ViewBuilder
  public func labelIconSpacingCompatible(_ spacing: CGFloat) -> some View {
    if #available(macOS 26, iOS 26, *) {
      labelIconToTitleSpacing(spacing)
    } else {
      self
    }
  }

  @ViewBuilder
  public func labelReservedIconWidthCompatible(_ value: CGFloat) -> some View {
    if #available(macOS 26, iOS 26, *) {
      labelReservedIconWidth(value)
    } else {
      self
    }
  }
}
