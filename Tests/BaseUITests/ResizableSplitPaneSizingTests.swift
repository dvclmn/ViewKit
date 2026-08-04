//
//  ResizableSplitPaneSizingTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/8/2026.
//

@testable import BaseUI
import Testing

@Suite("Resizable split pane sizing")
struct ResizableSplitPaneSizingTests {
  private let sizing = ResizableSplitPaneSizing(
    defaultWidth: 240,
    widthRange: 160...480,
  )

  @Test("uses a finite persisted width")
  func usesPersistedWidth() {
    #expect(sizing.width(storedWidth: 320) == 320)
  }

  @Test("applies cumulative drag translation to the persisted width")
  func appliesDragTranslation() {
    #expect(sizing.width(storedWidth: 240, dragTranslation: 35) == 275)
  }

  @Test("clamps widths to both limits")
  func clampsToWidthRange() {
    #expect(sizing.width(storedWidth: 240, dragTranslation: -200) == 160)
    #expect(sizing.width(storedWidth: 240, dragTranslation: 400) == 480)
  }

  @Test("falls back from a non-finite persisted value")
  func fallsBackFromNonFiniteValue() {
    #expect(sizing.width(storedWidth: .nan) == 240)
    #expect(sizing.width(storedWidth: .infinity) == 240)
  }
}
