//
//  PositionContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

extension Box {
  public struct PositionContext: Sendable {
    var rowIndex: Int
    var totalRows: Int
    public init(
      i rowIndex: Int,
      rowCount totalRows: Int
    ) {
      self.rowIndex = rowIndex
      self.totalRows = totalRows
    }
  }
}

extension Box.PositionContext {
  /// 0-based row number.
  var row: Int { rowIndex }

  /// 1-based row number (for more human-readable patterns).
  var rowNumber: Int { rowIndex + 1 }

  /// True if row is even (0, 2, 4…)
  var isEven: Bool { rowIndex.isMultiple(of: 2) }

  /// True if row is odd (1, 3, 5…)
  var isOdd: Bool { !isEven }

}

extension Box.PositionContext {
  /// Cycles through `0..<n`, useful for repeating sequences.
  func cycle(_ n: Int) -> Int { rowIndex % n }
  
  /// True every `n`th row (1-based)
  func isEvery(_ n: Int) -> Bool { (rowIndex + 1).isMultiple(of: n) }
  
  /// Returns a fraction (0–1) along the vertical span.
  var progress: Double {
    guard totalRows > 1 else { return 0 }
    return Double(rowIndex) / Double(totalRows - 1)
  }
  
  /// Returns an easing curve along the vertical span (for gradients etc.)
  func eased(using curve: (Double) -> Double) -> Double {
    curve(progress)
  }
  
  /// Returns one of two values depending on even/odd row.
  func alternating<T>(_ a: T, _ b: T) -> T {
    isEven ? a : b
  }
  
  /// Returns one of N values based on cycle index.
  func repeating<T>(_ values: [T]) -> T {
    values[cycle(values.count)]
  }
}
