//
//  AxisSelectable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

import Foundation

public protocol AxisSelectable {
  associatedtype Component

  func value(along axis: GridAxis, mapping: AxisMapping) -> Component
  func setting(_ newValue: Component, along axis: GridAxis, mapping: AxisMapping) -> Self
}
