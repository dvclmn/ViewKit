//
//  ScrubStep.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CoreTools

@AssociatedValues
public enum ScrubStrategy: Equatable {
  case continuous
  case stepped(Double)
}

/// For now, I will use the classic 1/10/100 steps w/ modifiers
/// for continuous, and the specific step size for stepped.
extension ScrubStrategy {
  public func stepSize(with modifiers: Modifiers) -> Double {
    steppedValue ?? steppedValue(from: modifiers)
  }

  private func steppedValue(from modifiers: Modifiers) -> Double {
    switch modifiers {
      case let mod where mod.contains(.command): 100
      case let mod where mod.contains(.shift): 10
      default: 1
    }
  }
}

extension HapticPreset {
  public static func scrubPreset(
    from scrubStrategy: ScrubStrategy,
    in range: ClosedRange<Double>,
    envOverride: Self?
  ) -> Self {
    if let envOverride { return envOverride }
    return switch scrubStrategy {
      case .continuous: .boundary(range)
      case .stepped(let value): .perStep(value)
    }
  }
}
