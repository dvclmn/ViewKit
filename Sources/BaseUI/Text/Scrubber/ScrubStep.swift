//
//  ScrubStep.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import InteractionKit
import BasePrimitives
import EnumMacros
import BaseTools

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

extension ScrubStrategy {
  public func scrubPreset(
    //    from scrubStrategy: ScrubStrategy,
    in range: ClosedRange<Double>?,
    envOverride: HapticPreset?
  ) -> HapticPreset {
    if let envOverride { return envOverride }
    switch self {
      case .continuous:
        guard let range else {
          return HapticPreset.none
        }
        return HapticPreset.boundary(range)
        
      case .stepped(let value):
        return HapticPreset.perStep(value)
    }
  }
}
