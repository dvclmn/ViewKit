//
//  Env+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import BasePrimitives
import SwiftUI

extension EnvironmentValues {

  @Entry public var gridDimensions: GridDimensions?
  @Entry public var gridFont: GridFont?
}

extension View {
  public func setGridDimensions(_ width: Int, height: Int) -> some View {
    self.environment(\.gridDimensions, GridDimensions(width, height))
  }
}
