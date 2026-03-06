//
//  InfiniteGridPathTests.swift
//  BaseHelpers
//
//  Created by Codex on 4/3/2026.
//

//import CoreGraphics
//import SwiftUI
//import Testing
//
//@testable import VectorKit
//
//@Suite("Infinite Grid Path Bounds")
//struct InfiniteGridPathTests {
//
//  @Test("When border is hidden, trailing/bottom off-container indices are skipped")
//  func skipsOffContainerIndicesWithoutBorder() {
//    var columnIndices: [Int] = []
//    var rowIndices: [Int] = []
//
//    _ = Path.infiniteGrid(
//      originOffset: .zero,
//      containerSize: CGSize(width: 100.1, height: 60.1),
//      cellSize: CGSize(width: 10, height: 10),
//      offset: .zero,
//      drawsBorder: false,
//      edgeEpsilon: 0.5,
//      onHorizontalIndex: { index, _ in columnIndices.append(index) },
//      onVerticalIndex: { index, _ in rowIndices.append(index) }
//    )
//
//    #expect(columnIndices == Array(1...9))
//    #expect(rowIndices == Array(1...5))
//  }
//
//  @Test("When border is shown, edge lines are kept but far trailing/bottom lines are skipped")
//  func keepsEdgesButSkipsFarOutsideIndices() {
//    var columnIndices: [Int] = []
//    var rowIndices: [Int] = []
//
//    _ = Path.infiniteGrid(
//      originOffset: .zero,
//      containerSize: CGSize(width: 100.1, height: 60.1),
//      cellSize: CGSize(width: 10, height: 10),
//      offset: .zero,
//      drawsBorder: true,
//      edgeEpsilon: 0.5,
//      onHorizontalIndex: { index, _ in columnIndices.append(index) },
//      onVerticalIndex: { index, _ in rowIndices.append(index) }
//    )
//
//    #expect(columnIndices == Array(0...10))
//    #expect(rowIndices == Array(0...6))
//    #expect(!columnIndices.contains(11))
//    #expect(!rowIndices.contains(7))
//  }
//}
