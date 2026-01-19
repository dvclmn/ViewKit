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
  public var stepSize: Double {
    steppedValue ?? 1.0
  }
}
