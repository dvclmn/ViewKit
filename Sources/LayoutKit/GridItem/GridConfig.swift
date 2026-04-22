//
//  GridConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import BasePrimitives
import SwiftUI

/// Note: this is specifically geared toward `LazyVGrid`,
/// `LazyHGrid` is not supported.
public struct GridConfig: Sendable {

  public let columns: ColumnConfig

  /// Based on `LazyVStack/spacing`
  /// This is the Vertical spacing
  public let spacingGrid: CGFloat?

  /// The alignment of the grid within its parent view
  /// Based on `LazyVStack/alignment`
  public let alignmentGrid: HorizontalAlignment

  public init(
    columnMode: ColumnConfig.Mode,
    spacingItem: CGFloat?,
    spacingGrid: CGFloat? = nil,
    alignmentItem: Alignment? = nil,
    alignmentGrid: HorizontalAlignment = .center,
  ) {
    self.spacingGrid = spacingGrid
    self.alignmentGrid = alignmentGrid

    self.columns = ColumnConfig(
      mode: columnMode,
      spacing: spacingItem ?? 8,
      alignment: alignmentItem,
    )
  }
}

extension GridConfig {

  public var gridItems: [GridItem] { self.columns.output }
}

extension GridConfig: CustomStringConvertible {
  public var description: String {
    return DisplayString {
      Indented("GridConfig") {
        columns.description
        Labeled("Spacing", value: spacingGrid?.displayString(.wholeNumber))
        "Spacing: \(spacingGrid?.displayString(.wholeNumber) ?? "nil")"
        "Alignnment: \(alignmentGrid.displayName))"

      }
    }.text

    //    """
    //    GridConfig [
    //      Column mode: \(columnMode)
    //      Spacing: Item[\(spacingItem.displayString)], Grid[\(spacingGrid?.displayString ?? "nil")]
    //      Alignnment: Item[\(alignmentItem?.displayName.standard ?? "nil")], Grid[\(alignmentGrid.displayName)]
    //    ]
    //    """
  }
}
