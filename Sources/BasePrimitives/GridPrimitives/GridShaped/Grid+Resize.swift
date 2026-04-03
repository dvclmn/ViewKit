//
//  Grid+Resize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation
import InteractionKit

extension GridShaped {

  public mutating func resize(
    by amount: GridDimensions,
    at edges: GridEdge.Set
  ) {
    let rows = amount.rows
    let columns = amount.columns

    for edge in GridEdge.allCases where edges.contains(GridEdge.Set(edge)) {
      switch edge.geometryAxis {
        case .vertical:
          if rows > 0 {
            addRows(to: edge, count: rows)
          } else if rows < 0 {
            removeRows(from: edge, count: -rows)
          }
        case .horizontal:
          if amount.columns > 0 {
            addColumns(to: edge, count: columns)
          } else if columns < 0 {
            removeColumns(from: edge, count: -columns)
          }
      }
    }
  }

  public mutating func resize(
    by amount: GridDimensions,
    at boundaryPoint: GridBoundaryPoint
  ) {
    let edges = boundaryPoint.affectedEdges
    self.resize(by: amount, at: edges)
  }

}
