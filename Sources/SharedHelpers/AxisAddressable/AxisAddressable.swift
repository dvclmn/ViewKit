//
//  AxisAddressable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

public protocol AxisAddressable {

  associatedtype Value

  func value(
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Value

  func setting(
    _ value: Value,
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Self
}

public protocol GridAxisAddressable {

  associatedtype Value

  func value(
    for axis: Axis2D,
    convention: GridAxisConvention
  ) -> Value

  func setting(
    _ value: Value,
    for axis: Axis2D,
    convention: GridAxisConvention
  ) -> Self
}
