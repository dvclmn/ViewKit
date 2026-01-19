//
//  Slider+Haptics.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import Foundation

public typealias HapticCondition = @Sendable (Double, Double) -> Bool

public enum HapticPreset: Sendable {
  case none
  case boundary(ClosedRange<Double>)
  case boundaryAndCentre(ClosedRange<Double>)
  case boundaryAndDefault(ClosedRange<Double>, defaultValue: Double)
  case perStep(Double)
  case custom(HapticCondition)

  func shouldFire(_ oldValue: Double, _ newValue: Double) -> Bool {

    let wiggleRoom: Double = 0.005
    switch self {
      case .none: return false

      case .boundary(let range):
        return newValue == range.lowerBound || newValue == range.upperBound

      case .boundaryAndCentre(let range):
        return newValue == range.lowerBound || newValue == range.upperBound
          || newValue == (range.upperBound - range.lowerBound) / 2

      case .boundaryAndDefault(let range, let defaultValue):
        return newValue == range.lowerBound
          || newValue == range.upperBound
          || abs(newValue - defaultValue) <= wiggleRoom

      case .perStep(let step):
        guard step > 0 else { return false }

        let oldBucket = Int(floor(oldValue / step))
        let newBucket = Int(floor(newValue / step))

        return oldBucket != newBucket

      case .custom(let condition):
        return condition(oldValue, newValue)

    }
  }
}

