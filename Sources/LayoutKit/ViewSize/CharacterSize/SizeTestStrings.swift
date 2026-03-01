//
//  SizeTestStrings.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import BasePrimitives
import Foundation

struct TestString {

  /// The string to test, to derive a single character width and height
  let text: String

  /// Manually specify the number of characters along the
  /// x and y / width and height / columns and rows
  ///
  /// This is trivial info to provide, and is one less job for the computer
  let width: Int
  let height: Int

  init(
    _ text: String, w: Int, h: Int
  ) {
    self.text = text
    self.width = w
    self.height = h
  }
}

extension TestString {

  func characterDimensions(
    in textBoundingSize: CGSize,
    at fontSize: CGFloat
  ) -> CharacterDimensions {
    let size = sizeInBounds(textBoundingSize)
    return CharacterDimensions.dimensions(
      size.width,
      size.height,
      at: fontSize
    )
  }

  /// The size of a single Character, based on the measurement
  /// of the full Test String dimensions, displayed / derived from a monospace font
  func singleCharacterSize(in textBoundingSize: CGSize) -> CGSize {
    let size = sizeInBounds(textBoundingSize)
    let result = CGSize(
      width: max(1, size.width),
      height: max(1, size.height)
    )
    return result
  }

  private func sizeInBounds(_ bounds: CGSize) -> CGSize {
    CGSize(
      width: bounds.width / CGFloat(width),
      height: bounds.height / CGFloat(height)
    )
  }
}

extension TestString {
  static var example01: TestString {
    TestString(
      """
      abcdefghijklmnopabcdefghijklmnopabcdefghijklmnop
      klmnopqrstuvwxyzklmnopqrstuvwxyzklmnopqrstuvwxyz
      123456789012345612345678901234561234567890123456
      ABCDEFGHIJKLMNOPABCDEFGHIJKLMNOPABCDEFGHIJKLMNOP
      abcdefghijklmnopabcdefghijklmnopabcdefghijklmnop
      klmnopqrstuvwxyzklmnopqrstuvwxyzklmnopqrstuvwxyz
      123456789012345612345678901234561234567890123456
      ABCDEFGHIJKLMNOPABCDEFGHIJKLMNOPABCDEFGHIJKLMNOP
      abcdefghijklmnopabcdefghijklmnopabcdefghijklmnop
      klmnopqrstuvwxyzklmnopqrstuvwxyzklmnopqrstuvwxyz
      123456789012345612345678901234561234567890123456
      ABCDEFGHIJKLMNOPABCDEFGHIJKLMNOPABCDEFGHIJKLMNOP
      """,
      w: 48,
      h: 12,
    )
  }

  static var boxParts: TestString {
    TestString(
      """
      //░[⣡│└┐◢┏║←↑→↓╳│┋┛abcdefghijklmnop
      !@#$%^&*()<>":{}|?!klmnopqrstuvwxyz
      //░[⣡│└┐◢┏║←↑→↓╳│┋┛1234567890123456
      !@#$%^&*()<>":{}|?!ABCDEFGHIJKLMNOP
      abcdefghijklmnop<>?KLMNOPQRSTUVWXYZ
      klmnopqrstuvwxyz<>?abcdefghijklmnop
      """,
      w: 35,
      h: 6,
    )
  }
}
