//
//  WaveChannel+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

//import CasePaths

extension WaveChannel {

  /// multiplicative around base, ignoring any prior edits to current
  public static func dotRadius(with wave: ConfiguredWave) -> Self {
    .init(wave: wave, elementKind: .dotRadius) { base, current, offset in
      max(0, base * (1 + offset))
    }
    //    .init(wave: wave, element: .dotRadius) { element, offset in
    //      guard let radius = element.dotRadiusValue else { return }
    //      element[case: \.dotRadius] = max(0, radius * (1 + offset))
    //    }
  }
  //
  public static func dotHorizontal(with wave: ConfiguredWave) -> Self {
    .init(wave: wave, elementKind: .dotRadius) { base, current, offset in
      base + offset
    }
  }
}

//extension CasePathable {
/// Convenience setter that accepts an Optional associated value.
/// If `newValue` is `nil`, this is a no-op. If non-nil and the case matches, it embeds the value.
///
/// This mirrors the standard CasePathable subscript(case:) setter behavior while
/// allowing a simple, optional-friendly write site.

//  public mutating func updateIfNeeded<Value>(
//    _ newValue: Value?,
//    at keyPath: CaseKeyPath<Self, Value>
//  ) {
//    guard let newValue else { return }
//    let `case` = Case(keyPath)
//    // Only embed when the current enum actually matches this case.
//    guard `case`._extract(from: self) != nil else { return }
//    self = `case`._embed(newValue) as! Self
//  }
//
//  @_disfavoredOverload
//  public subscript<Value>(case keyPath: CaseKeyPath<Self, Value>) -> Value? {
//    @available(*, unavailable)
//    get { fatalError() }
//    set {
//      // If there's nothing to write, do nothing.
//      guard let newValue else { return }
//      let `case` = Case(keyPath)
//      // Only embed when the current enum actually matches this case.
//      guard `case`._extract(from: self) != nil else { return }
//      self = `case`._embed(newValue) as! Self
//    }
//  }
//}
// MARK: - Optional numeric mutation helpers

//extension CasePathable {
//  /// Adds `rhs` to an Optional Double associated value for the given case.
//  /// If the optional is `nil` or the case doesn't match, this is a no-op.
//  public mutating func add(_ rhs: Double, to keyPath: CaseKeyPath<Self, Double>) {
//    let `case` = Case(keyPath)
//    guard let current = `case`._extract(from: self) else { return }
//    self = `case`._embed(current + rhs) as! Self
//  }
//
//  /// Subtracts `rhs` from an Optional Double associated value for the given case.
//  /// If the optional is `nil` or the case doesn't match, this is a no-op.
//  public mutating func subtract(_ rhs: Double, from keyPath: CaseKeyPath<Self, Double>) {
//    let `case` = Case(keyPath)
//    guard let current = `case`._extract(from: self) else { return }
//    self = `case`._embed(current - rhs) as! Self
//  }
//
//  /// Multiplies an Optional Double associated value for the given case by `rhs`.
//  /// If the optional is `nil` or the case doesn't match, this is a no-op.
//  public mutating func multiply(by rhs: Double, at keyPath: CaseKeyPath<Self, Double>) {
//    let `case` = Case(keyPath)
//    guard let current = `case`._extract(from: self) else { return }
//    self = `case`._embed(current * rhs) as! Self
//  }
//
//  /// Divides an Optional Double associated value for the given case by `rhs`.
//  /// If the optional is `nil` or the case doesn't match, this is a no-op.
//  public mutating func divide(by rhs: Double, at keyPath: CaseKeyPath<Self, Double>) {
//    let `case` = Case(keyPath)
//    guard let current = `case`._extract(from: self) else { return }
//    self = `case`._embed(current / rhs) as! Self
//  }
//}
