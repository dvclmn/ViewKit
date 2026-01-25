//
//  Int+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

extension Int {
  public var toCGFloat: CGFloat { CGFloat(self) }
  public var toDouble: Double { Double(self) }
  public func toBinaryFloatingPoint<T: BinaryFloatingPoint>() -> T { T(self) }

  /// Convert `self` (a value in seconds) and convert to H, M and S
  /// ```
  /// let seconds: Int = 26700
  /// let (h,m,s) = seconds.toHoursMinutesSeconds
  /// ```
  public var toHoursMinutesSeconds: (h: Int, m: Int, s: Int) {
    let h = self / 3600
    let m = (self % 3600) / 60
    let s = (self % 3600) % 60
    return (h, m, s)
  }

}

extension UInt32 {
  public var toInt: Int { Int(self) }
}

extension Int64 {
  public func toString() -> String { String(self) }
}
