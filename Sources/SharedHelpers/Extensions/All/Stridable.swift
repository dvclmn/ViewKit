//
//  Stridable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/1/2026.
//


import Foundation

// MARK: - Stridable Stepping Extension

extension Strideable {
  //extension Strideable where Stride: SignedNumeric & Comparable {
  
  /// Steps the value by the specified amount within the given range
  /// - Parameters:
  ///   - step: The amount to step by (positive or negative)
  ///   - range: The closed range to clamp the result within
  ///   - onEditingChanged: Optional callback triggered when stepping occurs, receives the old and new values
  /// - Returns: The new stepped value, clamped to the range
  public func stepping(
    by step: Stride,
    in range: ClosedRange<Self>,
    onEditingChanged: ((Self, Self) -> Void)? = nil
  ) -> Self {
    let oldValue = self
    let newValue = self.advanced(by: step)
    let clampedValue = min(max(newValue, range.lowerBound), range.upperBound)
    
    if oldValue != clampedValue {
      onEditingChanged?(oldValue, clampedValue)
    }
    
    return clampedValue
  }
  
  /// Steps the value up by the specified amount within the given range
  /// - Parameters:
  ///   - step: The amount to step up by (must be positive)
  ///   - range: The closed range to clamp the result within
  ///   - onEditingChanged: Optional callback triggered when stepping occurs
  /// - Returns: The new stepped value, clamped to the range
  public func steppingUp(
    by step: Stride,
    in range: ClosedRange<Self>,
    onEditingChanged: ((Self, Self) -> Void)? = nil
  ) -> Self {
    stepping(by: step, in: range, onEditingChanged: onEditingChanged)
  }
  
  /// Steps the value down by the specified amount within the given range
  /// - Parameters:
  ///   - step: The amount to step down by (must be positive, will be negated)
  ///   - range: The closed range to clamp the result within
  ///   - onEditingChanged: Optional callback triggered when stepping occurs
  /// - Returns: The new stepped value, clamped to the range
  public func steppingDown(
    by step: Stride,
    in range: ClosedRange<Self>,
    onEditingChanged: ((Self, Self) -> Void)? = nil
  ) -> Self {
    stepping(by: -step, in: range, onEditingChanged: onEditingChanged)
  }
  
  /// Checks if the value can be stepped in the given direction without exceeding the range
  /// - Parameters:
  ///   - step: The step amount (positive for up, negative for down)
  ///   - range: The closed range to check against
  /// - Returns: True if stepping is possible, false if it would exceed the range
  public func canStep(by step: Stride, in range: ClosedRange<Self>) -> Bool {
    let newValue = self.advanced(by: step)
    return newValue >= range.lowerBound && newValue <= range.upperBound
  }
}

// MARK: - Usage Examples

/// Example 1: Basic integer stepping
/// ```
/// var counter = 5
/// counter = counter.stepping(by: 2, in: 0...10)
/// print("Counter after stepping up: \(counter)") // 7
///
/// counter = counter.steppingDown(by: 3, in: 0...10)
/// print("Counter after stepping down: \(counter)") // 4
/// ```
///
/// Example 2: Double with callback
/// ```
/// var temperature = 20.5
/// temperature = temperature.stepping(by: 0.5, in: -10.0...30.0) { old, new in
///   print("Temperature changed from \(old)° to \(new)°")
/// }
/// ```
///
/// Example 3: Checking if step is possible
/// ```
/// let value = 95
/// let canIncrement = value.canStep(by: 10, in: 0...100) // true
/// let canIncrementMore = value.canStep(by: 20, in: 0...100) // false (would be 115)
/// ```
///
/// Example 4: CGFloat stepping (useful for UI values)
/// ```
/// import CoreGraphics
///
/// var opacity: CGFloat = 0.5
/// opacity = opacity.steppingUp(by: 0.1, in: 0.0...1.0)
/// print("Opacity: \(opacity)") // 0.6
/// ```
///
/// Example 5: Using in a loop with clamping
/// ```
/// var progress = 0
/// for _ in 1...15 {
///   progress = progress.stepping(by: 10, in: 0...100)
///   print("Progress: \(progress)")
/// }
/// // Will stop at 100 and stay there
/// ```
///
/// Example 6: Custom stepping logic with callback
/// ```
/// struct Volume {
///   var level: Double = 50.0
///
///   mutating func increase() {
///     level = level.stepping(by: 5, in: 0...100) { old, new in
///       print("Volume: \(old) → \(new)")
///     }
///   }
///
///   mutating func decrease() {
///     level = level.steppingDown(by: 5, in: 0...100)
///   }
/// }
///
/// var vol = Volume()
/// vol.increase() // Volume: 50.0 → 55.0
/// vol.decrease() // Back to 50.0
/// ```
