//
//  SizeTestStrings.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import Foundation
import SharedHelpers

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
      abcdefghijklmnop
      klmnopqrstuvwxyz
      1234567890123456
      ABCDEFGHIJKLMNOP
      KLMNOPQRSTUVWXYZ
      """,
      w: 16,
      h: 5,
    )
  }
  
  static var boxParts: TestString {
    TestString(
      """
      //░[⣡│└┐◢┏║←↑→↓╳│┋┛
      !@#$%^&*()<>":{}|?!
      //░[⣡│└┐◢┏║←↑→↓╳│┋┛
      !@#$%^&*()<>":{}|?!
      abcdefghijklmnop<>?
      klmnopqrstuvwxyz<>?
      """,
      w: 19,
      h: 6,
    )
  }
}
