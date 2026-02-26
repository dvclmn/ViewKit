//
//  GridGeometry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/2/2026.
//

import SwiftUI

extension EnvironmentValues {
  public var gridCanvasSize: CGSize? {
    //  public var gridGeometry: GridGeometry? {
    guard let unitSize else { return nil }
    guard let gridDimensions else { return nil }

    return gridDimensions.toScreenSize(using: unitSize)
  }
}
