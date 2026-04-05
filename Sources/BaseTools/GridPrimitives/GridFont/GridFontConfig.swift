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

  /// `passthrough` allows `CharacterSizeModifier` to measure
  /// whatever font is currently set in that View hierarchy
  case passthrough

  public static let automatic: Self = .domain(.automatic)
}

extension GridFontConfig {

  public func descriptor(in environment: EnvironmentValues) -> GridFontDescriptor? {
    switch self {
      case .domain(let domain, let explicitSize):

        /// First need to check if the domain is ASCII Mode, and if so, whether
        /// ASCII Mode is enabled. If not, return nil
        if domain == .asciiMode, !environment.isASCIIMode {
          return nil
        }

        let envFont = environment.gridFont
        let envSize = domain.fontSize(in: environment)

        let hasEnvFont = envFont != nil
        let hasSize = explicitSize != nil || envSize != nil

        guard let resolvedFont = envFont,
          let resolvedSize = explicitSize ?? envSize
        else { return nil }

        #if DEBUG
        if !hasEnvFont || !hasSize {
          let styleSource = hasEnvFont ? "environment" : "fallback"
          let sizeSource = hasSize ? (explicitSize == nil ? "environment" : "explicit") : "fallback"

          print(
            """
            ⚠️ GridFontConfig.domain(\(domain)) used fallback resolution.
               style: \(resolvedFont.rawValue) (\(styleSource))
               size: \(resolvedSize) (\(sizeSource))
               Provide env values for `gridFont` and the domain font size to avoid fallback.
            """
          )
        }
        #endif

        return GridFontDescriptor(style: resolvedFont, size: resolvedSize)

      case .custom(let font, let size):
        return GridFontDescriptor(style: font, size: size)

      case .passthrough: return nil
    }
  }
}
