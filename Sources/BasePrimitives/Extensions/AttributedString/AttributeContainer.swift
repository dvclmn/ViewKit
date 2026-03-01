//
//  AttributeContainer+Presets.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//

import SwiftUI

// MARK: - Quick colours
extension AttributeContainer {
  public static func colours(_ foreground: Color, on background: Color? = nil) -> AttributeContainer {
    var container = AttributeContainer()
    container.foregroundColor = foreground
    if let background {
      container.backgroundColor = background
    }
    return container
  }

  public static var blackOnWhite: Self { colours(.black, on: .white) }
  public static var whiteOnBlack: Self { colours(.white, on: .black) }
  public static var blackOnGreen: Self { colours(.black, on: .green) }
  public static var highlighter: Self { colours(.black, on: .green) }
  public static var blackOnOrange: Self { colours(.black, on: .orange.opacity(0.7)) }
  public static var secondary: Self { colours(.secondary) }
  public static var faint: Self { colours(.primary.opacity(0.16)) }
  public static var clear: Self { colours(.clear, on: .clear) }

}

extension AttributeContainer {

  public static func strikethrough(
    pattern: Text.LineStyle.Pattern,
    colour: Color? = Color.red
  ) -> AttributeContainer {
    var container = AttributeContainer()
    container.swiftUI.strikethroughStyle = .init(pattern: pattern, color: colour)
    return container
  }

  public static func underline(
    pattern: Text.LineStyle.Pattern,
    colour: Color? = Color.red
  ) -> AttributeContainer {
    var container = AttributeContainer()
    container.swiftUI.underlineStyle = .init(pattern: pattern, color: colour)
    return container
  }


  public func getAttributes<S: AttributeScope>(
    for scope: KeyPath<AttributeScopes, S.Type>
  ) -> NSTextAttributes? {
    do {
      return try Dictionary(self, including: scope)
    } catch {
      return nil
    }
  }

  #if canImport(UIKit)
  func getAttributes() -> NSTextAttributes? {
    return getAttributes(for: \.uiKit)
  }

  #elseif canImport(AppKit)
  func getAttributes() -> NSTextAttributes? {
    return getAttributes(for: \.appKit)
  }

  #endif

}
