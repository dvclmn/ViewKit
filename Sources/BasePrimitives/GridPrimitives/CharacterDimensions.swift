//
//  CharacterDimensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import Foundation

public struct CharacterDimensions {
  let width: CGFloat
  let height: CGFloat
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
