//
//  Joining.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import SwiftUI

/// Assumes horizontal joining
public func + (lhs: StringStack, rhs: StringStack) -> StringStack {
  return StringStack.joined(lhs, rhs, along: .horizontal)
}

public func += (lhs: inout StringStack, rhs: StringStack) {
  lhs = lhs + rhs
}

/// For repeating a `StringStack`
public func * (lhs: StringStack, rhs: Int) -> StringStack {
  var result = StringStack([])
  for _ in 0..<rhs {
    result = result + lhs
  }
  return result
}


extension StringStack {

  /// Right now, if padding is nil, shorter rows or columns simply “disappear” —
  /// this can lead to jagged edges. You might prefer to default to space
  /// padding when widths/heights don’t match, unless nil is explicitly
  /// intended to mean “truncate”.
  
  /// Explicit handling could help readability:
  /// `let padChar = padding ?? " "`
  public static func joined(
    _ strings: StringStack...,
    along axis: Axis,
    padding: Character? = nil
  ) -> StringStack {
    strings.reduce(StringStack([])) { partial, string in
      switch axis {
        case .horizontal:
          partial.joinedHorizontally(with: string, padding: padding)
          
        case .vertical:
          partial.joinedVertically(with: string, padding: padding)
      }
    }
  }
  
  func joinedHorizontally(
    with other: StringStack,
    padding: Character? = nil
  ) -> StringStack {
    let maxHeight = Swift.max(self.height, other.height)
    var result = StringStack([])
    
    for i in 0..<maxHeight {
      let left = self.row(at: i, paddedTo: self.width, with: padding)
      let right = other.row(at: i, paddedTo: other.width, with: padding)
      result.append(left + right)
    }
    
    return result
  }
  
  func joinedVertically(with other: StringStack, padding: Character? = nil) -> StringStack {
    let maxWidth = Swift.max(width, other.width)
    var result = self
    
    for i in 0..<other.height {
      let row = other.row(at: i, paddedTo: maxWidth, with: padding)
      result.append(row)
    }
    
    return result
  }
}


//extension StringStack {
//
//  public func joinWithCaps(
//    leading: StringStack,
//    trailing: StringStack,
//    errorGlyph: Character = "!"
//  ) -> StringStack {
//    let maxHeight = Swift.max(height, leading.height, trailing.height)
//    var result = StringStack([])
//
//    for i in 0..<maxHeight {
//      let leadingRow = i < leading.height ? leading[i] : [Character](repeating: errorGlyph, count: leading.width)
//      let contentRow = i < height ? self[i] : [Character](repeating: " ", count: width)
//      let trailingRow = i < trailing.height ? trailing[i] : [Character](repeating: errorGlyph, count: trailing.width)
//
//      /// I didn't know this until just recently, but if you supply `String` with
//      /// an array (or even, as below, multiple concatenated arrays!) of
//      /// `[Character]`, Swift will initialise this as... a `String`.
//      ///
//      /// It makes sense, but it wasn't something I would have assumed until
//      /// it was shown to me.
//      ///
//      /// That's what's happening here:
//      /// `String(leadingCapRow + row + trailingCapRow)`
//      ///
//      result.append(leadingRow + contentRow + trailingRow)
//    }
//
//    return result
//  }
//}
//
//
