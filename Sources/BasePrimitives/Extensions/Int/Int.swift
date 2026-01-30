//
//  Int.swift
//  Helpers
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

extension Int {
  //  public func normalisedIndexFloat(for count: Int) -> Float {
  //    count > 1
  //    ? Float(self) / Float(count - 1)
  //    : 0
  //  }

  /// Could also be called `fractionalPosition` or `unitPosition`
  public func normalisedIndex(for count: Int) -> CGFloat {
    return count > 1 ? CGFloat(self) / CGFloat(count - 1) : 0
  }
  public func normalisedIndex(for count: Int) -> Double {
    return count > 1 ? Double(self) / Double(count - 1) : 0
  }
  public func normalisedIndex(for count: Int) -> Float {
    return count > 1 ? Float(self) / Float(count - 1) : 0
  }
  

  public var doubled: Int { self * 2 }
  public var halved: Int { self / 2 }

  /// A Boolean value indicating whether the integer is even.
  public var isEven: Bool { self % 2 == 0 }

  public func isWithin(_ collection: some Collection) -> Bool {
    let startIndex = collection.startIndex
    let endIndex = collection.endIndex
    guard let index = collection.index(startIndex, offsetBy: self, limitedBy: endIndex) else {
      return false
    }
    return index < endIndex
  }

  public func isWithin(_ range: ClosedRange<Int>, isInclusive: Bool = true) -> Bool {
    guard isInclusive else {
      return self > range.lowerBound && self < range.upperBound
    }
    return self >= range.lowerBound && self <= (range.upperBound - 1)
  }

  public var columnType: NumberMagnitude {
    let absoluteValue = abs(self)

    return switch absoluteValue {
      case 0..<10: .ones
      case 10..<100: .tens
      case 100..<1000: .hundreds
      case 1000..<10000: .thousands
      case 10000..<100000: .tenThousands
      case 100000..<1_000_000: .hundredThousands
      case 1_000_000..<1_000_000_000: .millions
      default: .billions
    }
  }

  public var numberOfDigits: Int { String(abs(self)).count }

}

public enum NumberMagnitude: String {
  case ones = "ones"
  case tens = "tens"
  case hundreds = "hundreds"
  case thousands = "thousands"
  case tenThousands = "ten thousands"
  case hundredThousands = "hundred thousands"
  case millions = "millions"
  case billions = "billions"

  public var columnCount: Int {
    switch self {
      case .ones: 1
      case .tens: 2
      case .hundreds: 3
      case .thousands: 4
      case .tenThousands: 5
      case .hundredThousands: 6
      case .millions: 7
      case .billions: 8
    }
  }
}
