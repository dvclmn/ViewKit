//
//  SizeTestStrings.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import BasePrimitives
import Foundation

struct TestString {

  /// The string to test, to derive character width and height
  let text: String

  /// Manually specify the number of characters along the
  /// x and y (width and height).
  /// This saves the CPU from needing to calculate this
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

  /// The size of a single Character, based on the measurement
  /// of the full Test String dimensions
  func singleCharacterSize(in textBoundingSize: CGSize) -> CGSize {
    let width = textBoundingSize.width / CGFloat(width)
    let height = textBoundingSize.height / CGFloat(height)
    let result = CGSize(
      width: max(1, width),
      height: max(1, height)
    )
    return result
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
