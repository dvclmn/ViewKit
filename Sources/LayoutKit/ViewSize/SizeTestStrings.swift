//
//  SizeTestStrings.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import Foundation
import SharedHelpers
import GridKit

struct TestString {
  let text: String
  let dimensions: GridDimensions

  init(
    _ text: String,
    w: Int,
    h: Int
  ) {
    self.text = text
    self.dimensions = GridDimensions(w, h)
  }
}

extension TestString {

  /// The size of a single Character, based on the measurement
  /// of the full Test String dimensions
  func characterSize(_ size: CGSize) -> CGSize {
    let width = size.width / CGFloat(dimensions.width)
    let height = size.height / CGFloat(dimensions.height)
    let result = CGSize(
      width: width.clamped(1),
      height: height.clamped(1)
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
