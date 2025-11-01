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


