//
//  ShapeStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/8/2025.
//

import SwiftUI

extension ShapeStyle where Self == Color {
  public static var random: Color { Color.random }
}

extension Optional where Wrapped == AnyShapeStyle {
  public func withFallback(_ colour: Color) -> AnyShapeStyle {
    self ?? AnyShapeStyle(colour)
  }
//  public func fallingBack(to fallback: Color) -> Self {
//    //    guard let colour = fallback as? Wrapped else {
//    //      self?.
//    //    }
//    self ?? (fallback as! Wrapped)
//  }
}
