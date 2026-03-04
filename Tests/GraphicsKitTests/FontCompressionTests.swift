//
//  FontCompressionTests.swift
//  BaseHelpers
//
//  Created by Codex on 4/3/2026.
//

import CoreGraphics
import Testing

@testable import GraphicsKit

@Suite("Grid Annotation Font Compression")
struct FontCompressionTests {

  private let zoomRange: ClosedRange<CGFloat> = 0.25...4.0
  private let unitSize = CGSize(width: 10, height: 18)

  @Test("Opacity changes smoothly through the transition band")
  func opacityHasSoftTransition() {
    let samples = stride(from: 0.4, through: 1.2, by: 0.05).map { rawZoom in
      let zoom = CGFloat(rawZoom)
      let output = FontCompression(
        fontSize: 12,
        cellSize: unitSize,
        zoom: zoom,
        zoomRange: zoomRange,
        sensitivity: 0.2,
        characterCount: 2
      )
      .makeFont()
      return output.opacity
    }

    #expect(samples.contains { $0 > 0 && $0 < 1 })
  }

  @Test("Visibility transitions are monotonic as zoom increases")
  func visibilityTransitionsAtMostOnce() {
    let visibilities = stride(from: 0.2, through: 2.0, by: 0.02).map { rawZoom in
      let zoom = CGFloat(rawZoom)
      let output = FontCompression(
        fontSize: 12,
        cellSize: unitSize,
        zoom: zoom,
        zoomRange: zoomRange,
        sensitivity: 0.2,
        characterCount: 2
      )
      .makeFont()
      return output.visible
    }

    var transitions = 0
    for i in 1..<visibilities.count where visibilities[i] != visibilities[i - 1] {
      transitions += 1
    }

    #expect(transitions <= 1)
  }

  @Test("Returned opacity stays inside valid bounds")
  func opacityIsAlwaysWithinBounds() {
    let samples = stride(from: 0.1, through: 4.0, by: 0.05).map { rawZoom in
      let zoom = CGFloat(rawZoom)
      let output = FontCompression(
        fontSize: 12,
        cellSize: unitSize,
        zoom: zoom,
        zoomRange: zoomRange,
        sensitivity: 0.2,
        characterCount: 3
      )
      .makeFont()
      return output.opacity
    }

    #expect(samples.allSatisfy { $0 >= 0 && $0 <= 1 })
  }
}
