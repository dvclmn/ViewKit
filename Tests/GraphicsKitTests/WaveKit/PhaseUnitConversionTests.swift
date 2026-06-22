//
//  PhaseUnitConversionTests.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/6/2026.
//

import Foundation
import GraphicsKit
import Testing

@Suite("Phase unit conversion")
struct PhaseUnitConversionTests {

  private static let tolerance = 1e-12

  struct TurnsToRadiansCase: Sendable {
    let turns: Double
    let expectedRadians: Double
  }

  struct RadiansToTurnsCase: Sendable {
    let radians: Double
    let expectedTurns: Double
  }

  @Test(
    "Turns convert to radians",
    arguments: [
      TurnsToRadiansCase(turns: 0.0, expectedRadians: 0.0),
      TurnsToRadiansCase(turns: 0.25, expectedRadians: .pi / 2),
      TurnsToRadiansCase(turns: 0.5, expectedRadians: .pi),
      TurnsToRadiansCase(turns: 0.75, expectedRadians: 3 * .pi / 2),
    ],
  )
  func turnsConvertToRadians(_ testCase: TurnsToRadiansCase) {
    let phase = UnitPhase<Double>(testCase.turns)

    #expect(abs(phase.radians - testCase.expectedRadians) < Self.tolerance)
  }

  @Test(
    "Radians convert to wrapped turns",
    arguments: [
      RadiansToTurnsCase(radians: 0.0, expectedTurns: 0.0),
      RadiansToTurnsCase(radians: .pi / 2, expectedTurns: 0.25),
      RadiansToTurnsCase(radians: .pi, expectedTurns: 0.5),
      RadiansToTurnsCase(radians: 3 * .pi / 2, expectedTurns: 0.75),
      RadiansToTurnsCase(radians: -.pi / 2, expectedTurns: 0.75),
      RadiansToTurnsCase(radians: 5 * .pi / 2, expectedTurns: 0.25),
    ],
  )
  func radiansConvertToTurns(_ testCase: RadiansToTurnsCase) {
    let phase = RadiansPhase<Double>(testCase.radians)

    #expect(abs(phase.turns - testCase.expectedTurns) < Self.tolerance)
  }
}
