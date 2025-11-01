//
//  Joining.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import SwiftUI

public func + (lhs: StringStack, rhs: StringStack) -> StringStack {
  lhs.joinHorizontally(with: rhs)
}

public func += (lhs: inout StringStack, rhs: StringStack) {
  lhs = lhs + rhs
}

extension StringStack {
  public static func join(
    _ strings: StringStack...,
    along axis: Axis,
    padding: Character? = nil
  ) -> StringStack {
    strings.reduce(StringStack([])) { partial, string in
      switch axis {
        case .horizontal:
          partial.joinHorizontally(with: string, padding: padding)

        case .vertical:
          partial.joinVertically(with: string, padding: padding)
      }
    }
  }
}

// For repeating a StringStack
public func * (lhs: StringStack, rhs: Int) -> StringStack {
  var result = StringStack([])
  for _ in 0..<rhs {
    result = result + lhs
  }
  return result
}

extension StringStack {

  public func joinHorizontally(
    with other: StringStack,
    padding: Character? = nil
  ) -> StringStack {
    let maxHeight = Swift.max(self.height, other.height)
    var result = StringStack([])

    for i in 0..<maxHeight {
      let leftRow = i < self.height ? self[i] : []
      let rightRow = i < other.height ? other[i] : []

      if let padding = padding {
        let leftPadding = i < self.height ? [] : [Character](repeating: padding, count: self.width)
        let rightPadding = i < other.height ? [] : [Character](repeating: padding, count: other.width)
        result.append(leftPadding + leftRow + rightRow + rightPadding)
      } else {
        result.append(leftRow + rightRow)
      }
    }

    return result
  }

  public func joinVertically(with other: StringStack, padding: Character? = nil) -> StringStack {
    let maxWidth = Swift.max(self.width, other.width)
    var result = self

    for row in other {
      if let padding = padding {
        let paddedRow = row + [Character](repeating: padding, count: maxWidth - row.count)
        result.append(paddedRow)
      } else {
        result.append(row)
      }
    }

    return result
  }

  public func joinWithCaps(
    leading: StringStack,
    trailing: StringStack,
    errorGlyph: Character = "!"
  ) -> StringStack {
    let maxHeight = Swift.max(height, leading.height, trailing.height)
    var result = StringStack([])

    for i in 0..<maxHeight {
      let leadingRow = i < leading.height ? leading[i] : [Character](repeating: errorGlyph, count: leading.width)
      let contentRow = i < height ? self[i] : [Character](repeating: " ", count: width)
      let trailingRow = i < trailing.height ? trailing[i] : [Character](repeating: errorGlyph, count: trailing.width)

      /// I didn't know this until just recently, but if you supply `String` with
      /// an array (or even, as below, multiple concatenated arrays!) of
      /// `[Character]`, Swift will initialise this as... a `String`.
      ///
      /// It makes sense, but it wasn't something I would have assumed until
      /// it was shown to me.
      ///
      /// That's what's happening here:
      /// `String(leadingCapRow + row + trailingCapRow)`
      ///
      result.append(leadingRow + contentRow + trailingRow)
    }

    return result
  }
}
