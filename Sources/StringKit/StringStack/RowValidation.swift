//
//  RowValidation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import Foundation

extension StringStack {
  func patchedStack(
    _ stack: Stack,
    visualDebug: Bool
  ) -> Stack? {

    guard let firstRow = stack.first else {
      return nil
    }

    let alertSymbol: Character = "⚠️"
    let patchSymbol: Character = visualDebug ? alertSymbol : " "

    let targetWidth = firstRow.count
    var hasRowMismatch = false

    /// Check for Row mismatches
    for row in stack where row.count != targetWidth {
      hasRowMismatch = true
      break
    }

    if !hasRowMismatch { return nil }

    if visualDebug {
      print("⚠️ StringStack shape mismatch detected - applying visual patch:")
      print("Original: \(stack.map { String($0) })")
    }

    /// Handle mismatches by padding/truncating with symbol
    let patched = stack.map { row in
      if row.count == targetWidth {
        return row
      } else if row.count < targetWidth {
        /// Pad shorter rows
        return row + Array(repeating: patchSymbol, count: targetWidth - row.count)
      } else {
        /// Truncate longer rows and patch with symbol
        var newRow = Array(row.prefix(targetWidth - 1))
        newRow.append(patchSymbol)
        return newRow
      }
    }

    if visualDebug {
      print("Patched:  \(self.cells.map { String($0) })")
    }

    return patched

  }
}
