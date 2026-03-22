//
//  GridPositionConversionTests.swift
//  BaseHelpers
//
//  Created by Codex on 22/3/2026.
//

import CoreGraphics
import Testing

@testable import BasePrimitives

@Suite("Grid Position Conversions")
struct GridPositionConversionTests {

  private let unitSize = CGSize(width: 7, height: 11)

  @Test("GridPosition toScreenPoint uses column for x and row for y")
  func screenPointMapping() {
    let position = GridPosition(column: 3, row: 4)
    let point = position.toScreenPoint(using: unitSize)

    #expect(point.x == 21)
    #expect(point.y == 44)
  }

  @Test("GridRect converts to CGRect in screen space")
  func gridRectToCGRect() {
    let rect = GridRect(
      origin: GridPosition(column: 2, row: 5),
      size: GridDimensions(width: 4, height: 3)
    )
    let screenRect = CGRect(fromGridRect: rect, using: unitSize)

    #expect(screenRect.origin == CGPoint(x: 14, y: 55))
    #expect(screenRect.size == CGSize(width: 28, height: 33))
  }
}
