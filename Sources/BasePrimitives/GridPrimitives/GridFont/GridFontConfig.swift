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
        let hasStyleFromEnvironment = domain.gridFont(in: environment) != nil
        let hasSizeFromEnvironment = size != nil || domain.gridFontSize(in: environment) != nil

        let resolvedStyle = domain.gridFont(in: environment) ?? domain.fallbackFont
        let resolvedSize = size ?? domain.gridFontSize(in: environment) ?? domain.fallbackFontSize

        #if DEBUG
          if !hasStyleFromEnvironment || !hasSizeFromEnvironment {
            let styleSource = hasStyleFromEnvironment ? "environment" : "fallback"
            let sizeSource = hasSizeFromEnvironment ? (size == nil ? "environment" : "explicit") : "fallback"

            print(
              """
              ⚠️ GridFontConfig.domain(\(domain)) used fallback resolution.
                 style: \(resolvedStyle.rawValue) (\(styleSource))
                 size: \(resolvedSize) (\(sizeSource))
                 Provide env values for `gridFont` and the domain font size to avoid fallback.
              """
            )
          }
        #endif

        return GridFontDescriptor(style: resolvedStyle, size: resolvedSize)

      case .custom(let font, let size):
        return GridFontDescriptor(style: font, size: size)

      case .passthrough: return nil
    }
  }
}
