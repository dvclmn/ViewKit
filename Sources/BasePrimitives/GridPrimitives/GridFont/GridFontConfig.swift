//
//  GridFontConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

public enum GridFontConfig: Sendable {
  case domain(GridFontDomain, size: CGFloat? = nil)
  case custom(GridFont, size: CGFloat)

  /// `passthrough` allows `CharacterSizeModifier` to measure whatever
  /// font is currently set in that View hierarchy
  case passthrough

  public static let automatic: Self = .domain(.automatic)

  public func descriptor(in environment: EnvironmentValues) -> GridFontDescriptor? {
    switch self {
      case .domain(let domain, let size):
        guard let style = domain.gridFont(in: environment),
          let sizeResult = size ?? domain.gridFontSize(in: environment)
        else { return nil }
        return GridFontDescriptor(style: style, size: sizeResult)

      case .custom(let font, let size):
        return GridFontDescriptor(style: font, size: size)

      case .passthrough: return nil
    }
  }
}
