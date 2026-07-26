//
//  SliderHandlerTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 26/7/2026.
//

@testable import BaseUI
import Testing

@Suite("SliderHandler")
struct SliderHandlerTests {
  @Test("reports each editing transition once")
  func reportsDistinctPhases() {
    let handler = SliderHandler()
    var phases: [SliderPhase] = []

    handler.updatePhase(.dragging) { phases.append($0) }
    handler.updatePhase(.dragging) { phases.append($0) }
    handler.updatePhase(.idle) { phases.append($0) }

    #expect(phases == [.dragging, .idle])
  }

  @Test("uses the callback supplied by the current slider value")
  func usesCurrentCallback() {
    let handler = SliderHandler()
    var initialCallbackPhases: [SliderPhase] = []
    var replacementCallbackPhases: [SliderPhase] = []

    handler.updatePhase(.dragging) { initialCallbackPhases.append($0) }
    handler.updatePhase(.idle) { replacementCallbackPhases.append($0) }

    #expect(initialCallbackPhases == [.dragging])
    #expect(replacementCallbackPhases == [.idle])
  }
}
