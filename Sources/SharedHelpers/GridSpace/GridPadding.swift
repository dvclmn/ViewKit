//
//  GridPadding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import SwiftUI

public struct GridPadding {
  let edges: Edge.Set
  let padding: Int
//  let padding: GridDimensions
  
  public init(_ edges: Edge.Set, amount padding: Int) {
//  public init(_ edges: Edge.Set, amount padding: GridDimensions) {
    self.edges = edges
    self.padding = padding
  }
}
