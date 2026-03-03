//
//  GridShapedTests.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Testing

@testable import BasePrimitives

@Suite("GridShaped Editing")
struct GridEditingTests {

  struct G: GridShaped {
    typealias Cell = Character
    var cells: Rows
    init(cells: Rows) { self.cells = cells }
  }

  @Test
  func setAutoExpands() {
    var g = G(cells: [])
    g.set("X", at: .init(column: 3, row: 2))
    #expect(g.rowCount == 3)
    #expect(g.columnCount == 4)
    #expect(g[at: .init(column: 3, row: 2)] == "X")
  }

  @Test
  func removeColumnOnRaggedIsSafe() {
    var g = G(cells: [
      ["A", "B", "C"],
      ["D"],  // ragged
    ])
    g.addColumn(to: .trailing)
    g.removeColumn(from: .trailing)
    #expect(g.columnCount == 3)
    #expect(g.rows[1].count == 3)
  }
}
