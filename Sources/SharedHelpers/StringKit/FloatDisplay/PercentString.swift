//
//  PercentString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import Foundation

extension BinaryFloatingPoint {
  public func toPercent(within range: ClosedRange<Self>) -> Self {
    let normalised: Double = Double(self.normalised(from: range))
    return Self(normalised * 100)
  }
  
  public func toPercentString(within range: ClosedRange<Self>) -> String {
    let percent = Double(toPercent(within: range))
    return String(percent.displayString(places: 0) + "%")
  }
}
