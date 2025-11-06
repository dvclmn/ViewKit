//
//  Grid+Validation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import Foundation

extension GridShaped {
  public static func defaultRepair(
    _ cells: Cells,
    fallback: Cell
  ) -> Cells? {

    let targetWidth = cells.width(for: .widestRow)

    //    print("⚠️ Grid shape mismatch detected – applying patch:")
    //    print("Original: \(cells.map { "\($0)" }.joined(separator: " | "))")

    let patched = cells.map { row in
      if row.count == targetWidth {
        return row

      } else if row.count < targetWidth {
        return row + Array(repeating: fallback, count: targetWidth - row.count)

      } else {
        var newRow = Array(row.prefix(targetWidth - 1))
        newRow.append(fallback)
        return newRow
      }
    }

    //    if visualDebug {
    //    print("Patched:  \(patched.map { "\($0)" }.joined(separator: " | "))")
    //    }

    return patched
  }
}
