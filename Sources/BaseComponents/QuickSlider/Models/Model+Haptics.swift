//
//  Slider+Haptics.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import Foundation

/// Use the built-in "boundary reached" preset:
/// `let slider = QuickSlider($value, range: 0...100)`
///
/// Use a custom haptic feedback condition:
/// ```
/// let slider = QuickSlider($value, range: 0...100, hapticPreset: .custom { oldValue, newValue in
///   abs(newValue - oldValue) > 10
/// })
/// ```
public typealias HapticCondition = @Sendable (Double, Double) -> Bool

public enum HapticPreset: Sendable {
  case none
  case boundaryReached
  case boundaryAndCentre
  case boundaryAndDefault
  case custom(HapticCondition)
  
  func hapticPreset(
    for range: ClosedRange<Double>,
    with defaultValue: Double? = nil,
    _ oldValue: Double,
    _ newValue: Double
  ) -> Bool {
    
    let wiggleRoom: Double = 0.005
    switch self {
      case .none:
        return false
        
      case .boundaryReached:
        return newValue == range.lowerBound || newValue == range.upperBound
        
      case .boundaryAndCentre:
        return newValue == range.lowerBound || newValue == range.upperBound
        || newValue == (range.upperBound - range.lowerBound) / 2
        
      case .boundaryAndDefault:
        return newValue == range.lowerBound
        || newValue == range.upperBound
        || (defaultValue.map { abs(newValue - $0) <= wiggleRoom } ?? false)
        
      case .custom(let condition):
        return condition(oldValue, newValue)
        
    }
  }
  
}
