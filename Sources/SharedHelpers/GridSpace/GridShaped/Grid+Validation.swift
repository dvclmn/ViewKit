//
//  Grid+Validation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import Foundation

extension GridShaped {
  /// Returns a patched version of the grid if any row lengths differ.
  /// - Parameters:
  ///   - repair: A closure that defines how to repair each row.
  ///     The closure receives `(row, targetWidth)` and should return a new row of exactly that width.
  /// - Returns: A new patched grid, or `nil` if no patching was needed.
  public static func patchedGrid(
    _ cells: Cells,
    repair: @escaping (Row, Int) -> Row
  ) -> Cells? {

    guard let firstRow = cells.first else { return nil }

    let targetWidth = firstRow.count
    guard cells.contains(where: { $0.count != targetWidth }) else {
      return nil
    }

//      print("⚠️ Grid shape mismatch detected – applying patch:")
//      print("Original: \(cells.map { "\($0)" }.joined(separator: " | "))")


    let patched = cells.map { row in
      row.count == targetWidth ? row : repair(row, targetWidth)
    }

//      print("Patched:  \(patched.map { "\($0)" }.joined(separator: " | "))")

    return patched
  }
}


//extension GridShaped where Self.Cell == Character {
//  
//  public static func repair(
//    row: Row,
//    targetWidth: Int,
//    fill: Character = " "
//  ) -> Row {
//    if row.count == targetWidth {
//      return row
//
//    } else if row.count < targetWidth {
//      return row + Array(repeating: fill, count: targetWidth - row.count)
//
//    } else {
//      var newRow = Array(row.prefix(targetWidth - 1))
//      newRow.append(fill)
//      return newRow
//    }
//  }
//
//}

/// Default repair that simply pads or truncates with the last element (if any)
//  static func defaultRepair(
//    row: Row,
//    targetWidth: Int,
//    fallback: Value
//  ) -> Row {
//    guard !row.isEmpty else {
//      return Array(repeating: row.first ?? fallback, count: targetWidth)
//    }
//    guard row.count < targetWidth else {
//      return Array(row.prefix(targetWidth))
//    }
//    return row + Array(repeating: row.last!, count: targetWidth - row.count)
//  }
//}
// MARK: - Patching for String/Character based
//extension GridShaped where Value == Character {
//  static func defaultRepair(row: Row, targetWidth: Int, fill: Character = " ") -> Row {
//    guard row.count < targetWidth else {
//      var newRow = Array(row.prefix(targetWidth - 1))
//      newRow.append(fill)
//      return newRow
//    }
//    return row + Array(repeating: fill, count: targetWidth - row.count)
//  }
//}
//  static func patchedGrid(
//    _ cells: Cells,
//    visualDebug: Bool
//  ) -> Cells? {
//
//    guard let firstRow = cells.first else {
//      return nil
//    }
//
//    let alertSymbol: Character = "⚠️"
//    let patchSymbol: Character = visualDebug ? alertSymbol : " "
//
//    let targetWidth = firstRow.count
//    var hasRowMismatch = false
//
//    /// Check for Row mismatches
//    for row in cells where row.count != targetWidth {
//      hasRowMismatch = true
//      break
//    }
//
//    if !hasRowMismatch { return nil }
//
//    if visualDebug {
//      print("⚠️ StringStack shape mismatch detected - applying visual patch:")
//      print("Original: \(cells.map { String($0.description) })")
//    }
//
//    /// Handle mismatches by padding/truncating with symbol
//    let patched = cells.map { row in
//      if row.count == targetWidth {
//        return row
//      } else if row.count < targetWidth {
//        /// Pad shorter rows
//        return row + Array(repeating: patchSymbol, count: targetWidth - row.count)
//      } else {
//        /// Truncate longer rows and patch with symbol
//        var newRow = Array(row.prefix(targetWidth - 1))
//        newRow.append(patchSymbol)
//        return newRow
//      }
//    }
//
////    if visualDebug {
////      print("Patched:  \(self.cells.map { String($0.description) })")
////    }
//
//    return patched
//
//  }
//}
