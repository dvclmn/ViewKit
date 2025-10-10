//
//  PercentString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import Foundation

extension BinaryFloatingPoint {

  public func toPercentString(within range: ClosedRange<Self>) -> String {
    let normalised: Double = Double(self.normalised(from: range))
    let percent = normalised * 100
    return String(percent.displayString(places: 0) + "%")
  }
}
