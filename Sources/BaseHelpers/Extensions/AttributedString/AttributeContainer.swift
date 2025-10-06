//
//  AttributeContainer+Presets.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//

import Foundation
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
  public static var clear: Self { colours(.clear, on: .clear) }
//  public static var blackOnOrange: Self { colours(.black, on: .orange.opacity(0.7)) }


}

extension AttributeContainer {
  
  public static func strikeThrough(
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
  

//  public static var highlighter: AttributeContainer {
//    return quickContainer(foreground: .black, background: .green)
//  }

//  public static var searchMatch: AttributeContainer {
//    return quickContainer(foreground: .black, background: .yellow)
//  }

//  public static var neonOrangeSoft: AttributeContainer {
//    return quickContainer(foreground: .black, background: .orange.opacity(0.7))
//  }
//
//  public static var neonOrange: AttributeContainer {
//    return quickContainer(foreground: .white, background: .orange.opacity(0.5))
//  }
//
//  public static var faded: AttributeContainer {
//    return quickContainer(foreground: .white.opacity(0.4), background: .clear)
//  }

//  public static var invisible: AttributeContainer {
//    return quickContainer(foreground: .clear, background: .clear)
//  }

//  public static var blackOnWhite: AttributeContainer {
//    return quickContainer()
//  }
//
//  public static var whiteOnBlack: AttributeContainer {
//    return quickContainer(foreground: .white, background: .black)
//  }
  

//  public static func quickContainer(
//    foreground: Color = .black,
//    background: Color = .white,
//  ) -> AttributeContainer {
//
//    var container = AttributeContainer()
//    container.foregroundColor = foreground
//    container.backgroundColor = background
////    container.cursor = .closedHand
//    container.swiftUI.strikethroughStyle = .init(pattern: .dot, color: Color.red)
//
//    return container
//
//  }

  public func getAttributes<S: AttributeScope>(
    for scope: KeyPath<AttributeScopes, S.Type>
  ) -> [NSAttributedString.Key: Any]? {
    do {
      return try Dictionary(self, including: scope)
    } catch {
      return nil
    }
  }

  #if canImport(UIKit)
  func getAttributes() -> [NSAttributedString.Key: Any]? {
    return getAttributes(for: \.uiKit)
  }

  #elseif canImport(AppKit)
  func getAttributes() -> [NSAttributedString.Key: Any]? {
    return getAttributes(for: \.appKit)
  }

  #endif

}
