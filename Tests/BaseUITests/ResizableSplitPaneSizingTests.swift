//
//  ResizableSplitPaneSizingTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/8/2026.
//

@testable import BaseUI
import SwiftUI
import Testing

@Suite("Resizable split pane sizing")
struct ResizableSplitPaneSizingTests {
  private let sizing = ResizableSplitPaneSizing(
    defaultLength: 240,
    lengthRange: 160...480,
  )

  @Test("uses a finite persisted length")
  func usesPersistedLength() {
    #expect(sizing.length(storedLength: 320) == 320)
  }

  @Test("applies cumulative drag translation to the persisted length")
  func appliesDragTranslation() {
    #expect(sizing.length(storedLength: 240, dragTranslation: 35) == 275)
  }

  @Test("clamps lengths to both limits")
  func clampsToLengthRange() {
    #expect(sizing.length(storedLength: 240, dragTranslation: -200) == 160)
    #expect(sizing.length(storedLength: 240, dragTranslation: 400) == 480)
  }

  @Test("falls back from a non-finite persisted value")
  func fallsBackFromNonFiniteValue() {
    #expect(sizing.length(storedLength: .nan) == 240)
    #expect(sizing.length(storedLength: .infinity) == 240)
  }
}

@Suite("Resizable split pane edges")
struct ResizableSplitPaneEdgeTests {
  @Test("maps edges to their resize axes")
  func mapsEdgesToResizeAxes() {
    #expect(ResizableSplitPaneEdge(.leading).resizeAxis == .horizontal)
    #expect(ResizableSplitPaneEdge(.trailing).resizeAxis == .horizontal)
    #expect(ResizableSplitPaneEdge(.top).resizeAxis == .vertical)
    #expect(ResizableSplitPaneEdge(.bottom).resizeAxis == .vertical)
  }

  @Test("outward drags increase the pane length")
  func outwardDragsIncreaseLength() {
    #expect(
      ResizableSplitPaneEdge(.leading).lengthTranslation(
        from: CGSize(width: -32, height: 24),
        layoutDirection: .leftToRight,
      ) == 32
    )
    #expect(
      ResizableSplitPaneEdge(.trailing).lengthTranslation(
        from: CGSize(width: 32, height: 24),
        layoutDirection: .leftToRight,
      ) == 32
    )
    #expect(
      ResizableSplitPaneEdge(.top).lengthTranslation(
        from: CGSize(width: 32, height: -24),
        layoutDirection: .leftToRight,
      ) == 24
    )
    #expect(
      ResizableSplitPaneEdge(.bottom).lengthTranslation(
        from: CGSize(width: 32, height: 24),
        layoutDirection: .leftToRight,
      ) == 24
    )
  }

  @Test("leading and trailing drags follow the layout direction")
  func horizontalDragsFollowLayoutDirection() {
    #expect(
      ResizableSplitPaneEdge(.leading).lengthTranslation(
        from: CGSize(width: 32, height: 24),
        layoutDirection: .rightToLeft,
      ) == 32
    )
    #expect(
      ResizableSplitPaneEdge(.trailing).lengthTranslation(
        from: CGSize(width: -32, height: 24),
        layoutDirection: .rightToLeft,
      ) == 32
    )
  }

  @Test("centres the handle on each pane boundary")
  func centresHandleOnPaneBoundary() {
    #expect(
      ResizableSplitPaneEdge(.leading).handleOffset(
        handleThickness: 18,
        layoutDirection: .leftToRight,
      ) == CGSize(width: -9, height: 0)
    )
    #expect(
      ResizableSplitPaneEdge(.trailing).handleOffset(
        handleThickness: 18,
        layoutDirection: .leftToRight,
      ) == CGSize(width: 9, height: 0)
    )
    #expect(
      ResizableSplitPaneEdge(.top).handleOffset(
        handleThickness: 18,
        layoutDirection: .leftToRight,
      ) == CGSize(width: 0, height: -9)
    )
    #expect(
      ResizableSplitPaneEdge(.bottom).handleOffset(
        handleThickness: 18,
        layoutDirection: .leftToRight,
      ) == CGSize(width: 0, height: 9)
    )
    #expect(
      ResizableSplitPaneEdge(.leading).handleOffset(
        handleThickness: 18,
        layoutDirection: .rightToLeft,
      ) == CGSize(width: 9, height: 0)
    )
  }
}
