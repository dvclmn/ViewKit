//
//  Grid+Validation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import Foundation

public struct GridNormalizationPolicy<Cell> {
  public var alignment: GridAlignment = .leading
  public var targetWidth: Int? = nil  // nil means use widest line
  public var padCell: Cell
  public var truncationCell: Cell? = nil
  public var padLastLine: Bool = true  // If false, avoid padding last line

  public init(
    alignment: GridAlignment = .leading,
    targetWidth: Int? = nil,
    padCell: Cell,
    truncationCell: Cell? = nil,
    padLastLine: Bool = true
  ) {
    self.alignment = alignment
    self.targetWidth = targetWidth
    self.padCell = padCell
    self.truncationCell = truncationCell
    self.padLastLine = padLastLine
  }
}

extension GridShaped {
  public static func normaliseRows(
    _ ragged: [[Cell]],
    policy: GridNormalizationPolicy<Cell>
  ) -> [[Cell]] {
    let width = policy.targetWidth ?? (ragged.map(\.count).max() ?? 0)
    guard width > 0 else { return ragged }

    return ragged.enumerated().map { index, row in
      let isLast = index == ragged.count - 1
      let pad = policy.padLastLine || !isLast
      return normalisedRows(
        row.count == width || !pad ? [row] : [row],
        alignment: policy.alignment,
        paddingCell: policy.padCell,
        truncationCell: policy.truncationCell
      ).first ?? row
    }
  }
}

extension GridShaped {

  /// Previous was too strict, and required that the given column index be valid in every row.
  /// Have removed the `isColumnValidAcrossAllRows` requirement.
  ///
  /// E.g.:
  /// - If grid is ragged, then for any column index ≥ the shortest row’s length,
  ///   `rows​.all​Satisfy { $0​.count > column }` fails.
  /// - If any row is empty, then even column 0 is considered invalid,
  ///   making every position invalid across the entire grid.
  /// - Because `column​Count` is `widest​Row`, `to​String() `will iterate
  ///   up to the widest row’s width, but the subscript will reject any column not present in
  ///   all rows, returning nil for many cells. `to​String()` then replaces them with blanks.
  func isPositionValid(_ position: GridPosition) -> Bool {
    guard isRowValid(position.row) else { return false }
    let row = rows[position.row]
    return position.column >= 0 && position.column < row.count
  }

  //  func isPositionValid(_ position: GridPosition) -> Bool {
  //    isRowValid(position.row) && isColumnValidAcrossAllRows(position.column)
  //  }

  /// Check that this row index is within the table’s bounds
  func isRowValid(_ row: Int) -> Bool {
    row >= 0 && row < rowCount
  }

  func isColumnIndexNonNegative(_ column: Int) -> Bool {
    column >= 0
  }

  func isColumnValidInAnyRow(_ column: Int) -> Bool {
    column >= 0 && rows.contains { $0.count > column }
  }

  @available(
    *, deprecated, message: "Is arguably too strict for common use, was causing a lot of blank cells"
  )
  func isColumnValidAcrossAllRows(_ column: Int) -> Bool {
    !rows.isEmpty
      && column >= 0
      && column < width
      && rows.allSatisfy { $0.count > column }
  }
}

public struct RowNormaliser<T: GridShaped> {
  let rows: T.Rows
  let paddingCell: T.Cell
  let truncationCell: T.Cell?
  let alignment: GridAlignment

  public init(
    rows: T.Rows,
    paddingCell: T.Cell,
    truncationCell: T.Cell?,
    alignment: GridAlignment = .leading
  ) {
    self.rows = rows
    self.paddingCell = paddingCell
    self.truncationCell = truncationCell
    self.alignment = alignment
  }
}

extension RowNormaliser {

  public var normalised: T.Rows {
    let targetWidth = rows.width(for: .widestRow)
    let patched: T.Rows = rows.map { patchedRow($0, width: targetWidth) }
    return patched
  }

  /// This `targetWidth` will usually be the widest row width,
  /// so I think usually we won't truncate? But handy that it's here I suppose.
  ///
  /// If a Row is too long (longer than `targetWidth`), it will be truncated.
  /// If supplied, the `truncationIndicator` will cause one *additional*
  /// cell to be removed from the end of the Row, and the indicator put in it's place.
  /// Either for visual debugging, or just to denote truncation.
  private func patchedRow(
    _ row: T.Row,
    width targetWidth: Int
  ) -> T.Row {
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

    let padWidth = targetWidth - row.count
    let padding = Array(repeating: paddingCell, count: padWidth)

    return switch alignment {
      case .leading: row + padding
      case .trailing: padding + row
    }
  }
}

extension GridShaped {

  public static func normalisedRows(
    _ rows: Rows,
    alignment: GridAlignment = .leading,
    paddingCell: Cell,
    truncationCell: Cell?
  ) -> Rows {

    let normaliser = RowNormaliser<Self>(
      rows: rows,
      paddingCell: paddingCell,
      truncationCell: truncationCell,
      alignment: alignment
    )

    return normaliser.normalised

  }

}
