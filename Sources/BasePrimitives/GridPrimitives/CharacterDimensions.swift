//
//  CharacterDimensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import Foundation

public protocol CharacterSize {
  var width: CGFloat { get }
  var height: CGFloat { get }
}

extension CGSize: CharacterSize {}

public struct CharacterDimensions: CharacterSize {
  public let width: CGFloat
  public let height: CGFloat
  let fontSize: CGFloat
}

extension CharacterDimensions {
  public static func dimensions(
    _ width: CGFloat,
    _ height: CGFloat,
    at fontSize: CGFloat
  ) -> Self {
    Self(width: width, height: height, fontSize: fontSize)
  }
}
