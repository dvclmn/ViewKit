//
//  ControlSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/9/2025.
//

import SwiftUI

extension ControlSize {

  public var scaleFactor: CGFloat {
    switch self {
      case .mini: 0.45
      case .small: 0.7
      case .regular: 1.0
      case .large: 1.15
      case .extraLarge: 1.3
      @unknown default: 1.0
    }
  }

  public var textStyle: Font.TextStyle {
    //  public var fontSize: CGFloat {
    switch self {
      case .mini: .caption2
      case .small: .callout
      case .regular: .body
      case .large: .title
      case .extraLarge: .largeTitle
      @unknown default: .body
    }
  }

  public func scale(
    _ value: CGFloat,
    //    for controlSize: ControlSize,
    by strength: CGFloat = 1.0,
    min: CGFloat = 0
  ) -> CGFloat {
    let result = value * self.scaleFactor * strength
    return max(min, result)
  }

}
