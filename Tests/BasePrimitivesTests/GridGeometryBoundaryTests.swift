//
//  GridGeometryBoundaryTests.swift
//  BaseHelpers
//
//  Created by Codex on 4/3/2026.
//

import CoreGraphics
import Testing

@testable import BasePrimitives

@Suite("Grid Geometry Boundary Mapping")
struct GridGeometryBoundaryTests {

  private let geometry = GridGeometry(
    viewportRect: .zero,
    dimensions: GridDimensions(width: 10, height: 8),
    unitSize: CGSize(width: 12, height: 20)
  )

  @Test("Maps interior points to valid row/column")
  func mapsInteriorPoints() {
    let point = CGPoint(x: 11.99, y: 19.99)
    let position = point.gridPosition(geometry: geometry)

    #expect(position == GridPosition(column: 0, row: 0))
  }

  @Test("Rejects trailing and bottom edge points")
  func rejectsMaxEdges() {
    let trailingEdge = CGPoint(x: 120, y: 10)
    let bottomEdge = CGPoint(x: 10, y: 160)

    #expect(trailingEdge.gridPosition(geometry: geometry) == nil)
    #expect(bottomEdge.gridPosition(geometry: geometry) == nil)
  }

  @Test("Rejects negative points")
  func rejectsNegativePoints() {
    let negativeX = CGPoint(x: -0.01, y: 10)
    let negativeY = CGPoint(x: 10, y: -0.01)

    #expect(negativeX.gridPosition(geometry: geometry) == nil)
    #expect(negativeY.gridPosition(geometry: geometry) == nil)
  }
}
