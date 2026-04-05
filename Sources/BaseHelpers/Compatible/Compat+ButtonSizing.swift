//
//  Compat+ButtonSizing.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/2/2026.
//

import SwiftUI

/// The sizing behavior of `Button`s and other button-like controls.
public enum ButtonSizingCompatible: Hashable, Sendable {
  case automatic
  case flexible
  case fitted
}

@available(macOS 26, iOS 26, *)
extension ButtonSizingCompatible {
  var toButtonSizing: ButtonSizing {
    switch self {
      case .automatic: .automatic
      case .flexible: .flexible
      case .fitted: .fitted
    }
  }
}

extension View {
  @ViewBuilder
  public func buttonSizingCompatible(_ sizing: ButtonSizingCompatible) -> some View {
    if #available(macOS 26, iOS 26, *) {
      buttonSizing(sizing.toButtonSizing)
    } else {
      self
    }
  }
}
