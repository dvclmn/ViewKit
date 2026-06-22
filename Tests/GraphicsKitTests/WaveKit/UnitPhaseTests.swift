//
//  UnitPhaseTests.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/6/2026.
//

import Foundation
import GraphicsKit
import Testing

@Suite("Unit phase")
struct UnitPhaseTests {

  private static let tolerance = 1e-12

  struct TurnsCase: Sendable {
    let input: Double
    let expected: Double
  }

  @Test(
    "Initialisation wraps turns into the unit interval",
    arguments: [
      TurnsCase(input: 0.0, expected: 0.0),
      TurnsCase(input: 0.25, expected: 0.25),
      TurnsCase(input: 1.0, expected: 0.0),
      TurnsCase(input: 1.25, expected: 0.25),
      TurnsCase(input: -0.25, expected: 0.75),
      TurnsCase(input: -1.0, expected: 0.0),
      TurnsCase(input: 10.75, expected: 0.75),
    ]
  )
  func initialisationWrapsTurns(_ testCase: TurnsCase) {
    let phase = UnitPhase<Double>(testCase.input)

    #expect((0.0..<1.0).contains(phase.turns))
    #expect(abs(phase.turns - testCase.expected) < Self.tolerance)
  }

  @Test("Advancing wraps forwards")
  func advancingWrapsForwards() {
    var phase = UnitPhase<Double>(0.9)

    phase.advance(by: 0.25)

    #expect(abs(phase.turns - 0.15) < Self.tolerance)
  }

  @Test("Advancing wraps backwards")
  func advancingWrapsBackwards() {
    var phase = UnitPhase<Double>(0.1)

    phase.advance(by: -0.25)

    #expect(abs(phase.turns - 0.85) < Self.tolerance)
  }

  @Test("Decoding wraps an out-of-range value")
  func decodingWrapsTurns() throws {
    let encoded = try JSONEncoder().encode(PhasePayload(turns: 1.25))

    let phase = try JSONDecoder().decode(UnitPhase<Double>.self, from: encoded)

    #expect(abs(phase.turns - 0.25) < Self.tolerance)
  }

  @Test("Encoding preserves the keyed turns representation")
  func encodingPreservesRepresentation() throws {
    let encoded = try JSONEncoder().encode(UnitPhase<Double>(0.25))

    let payload = try JSONDecoder().decode(PhasePayload.self, from: encoded)

    #expect(abs(payload.turns - 0.25) < Self.tolerance)
  }

  private struct PhasePayload: Codable {
    let turns: Double
  }
}
