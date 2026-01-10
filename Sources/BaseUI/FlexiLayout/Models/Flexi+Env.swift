//
//  Flexi+Env.swift
//  BaseComponents
//
//  Created by Dave Coleman on 2/10/2025.
//

import SwiftUI
import BasePrimitives
import LayoutKit

extension EnvironmentValues {
  @Entry public var layoutMode: LayoutMode? = nil
  @Entry public var maskedScrollAreas: ScrollMaskArea? = nil
  @Entry public var selectionMode: SelectionMode? = nil
  @Entry public var gridConfig: GridConfig? = nil
  @Entry public var gridItemSpacing: CGFloat? = nil
  @Entry public var gridColumnMode: ColumnConfig.Mode? = nil
}
