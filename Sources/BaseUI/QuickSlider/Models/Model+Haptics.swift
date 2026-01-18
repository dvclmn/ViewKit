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
  case boundary(HapticBoundary)
//  case boundaryReached
//  case boundaryAndCentre
//  case boundaryAndDefault
  case perStep(Int)
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
        
      case .boundary(let settings):
//      case .boundaryReached:
        return newValue == range.lowerBound || newValue == range.upperBound
        
      case .boundaryAndCentre:
        return newValue == range.lowerBound || newValue == range.upperBound
        || newValue == (range.upperBound - range.lowerBound) / 2
        
      case .boundaryAndDefault:
        return newValue == range.lowerBound
        || newValue == range.upperBound
        || (defaultValue.map { abs(newValue - $0) <= wiggleRoom } ?? false)
        
      case .perStep(let step):
        return
        
      case .custom(let condition):
        return condition(oldValue, newValue)
        
    }
  }
  
}

public struct HapticBoundary: Sendable {
  let range: ClosedRange<CGFloat>
  let markers: HapticMarkers
  
  public init(_ range: ClosedRange<CGFloat>, markers: HapticMarkers) {
    self.range = range
    self.markers = markers
  }
}
extension HapticBoundary {
  public static func boundaryReached(_ range: ClosedRange<CGFloat>) -> Self {
    Self(range, markers: .boundary)
  }
}

public struct HapticMarkers: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int
  
  public static let boundary = Self(rawValue: 1 << 0)
  public static let centre = Self(rawValue: 1 << 1)
  public static let defaultValue = Self(rawValue: 1 << 2)

}
