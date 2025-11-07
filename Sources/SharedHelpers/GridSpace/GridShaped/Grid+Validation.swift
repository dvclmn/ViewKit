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
    padCell: Cell,
    truncationCell: Cell?
  ) -> Cells {

    let targetWidth = cells.width(for: .widestRow)

    let patched: Cells = cells.map { row in
      patchedRow(
        row,
        targetWidth: targetWidth,
        padCell: padCell,
        truncationCell: truncationCell
      )
    }

    return patched
  }

  /// This `targetWidth` will usually be the widest row width,
  /// so I think usually we won't truncate? But handy that it's here I suppose.
  ///
  /// If a Row is too long (longer than `targetWidth`), it will be truncated.
  /// If supplied, the `truncationIndicator` will cause one *additional*
  /// cell to be removed from the end of the Row, and the indicator put in it's place.
  /// Either for visual debugging, or just to denote truncation.
  private static func patchedRow(
    _ row: Row,
    targetWidth: Int,
    padCell: Cell,
    truncationCell: Cell?
  ) -> Row {
    /// This Row is already the right width, so return it untouched
    guard row.count != targetWidth else { return row }

    guard row.count < targetWidth else {
      /// This Row is too long
      guard let truncationCell else {
        /// Just crop the row
        return Array(row.prefix(targetWidth))
      }
      /// If a truncation Cell is provided, we add it at the last-available Cell
      /// (removing `1` from the count, so we're not *adding* to the row width)
      let truncated = Array(row.prefix(targetWidth - 1))
      let newRow = truncated + [truncationCell]
      return newRow
    }
    /// If we're here, the Row is too short, and needs to be padded
    /// If no fallback supplied, default to a space
    return row + Array(repeating: padCell, count: targetWidth - row.count)
  }
}
