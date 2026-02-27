//
//  ConversionSafetyCheck.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation

package func isSafeToConvert<Value: BinaryInteger>(
  _ value: Value,
  unitLength: CGFloat
) -> Bool {
  value >= 0 && unitLength > 0 && unitLength.isFinite
}

package func isSafeToConvert<Value: BinaryFloatingPoint>(
  _ value: Value,
  unitLength: CGFloat
) -> Bool {
  value >= 0 && unitLength > 0 && unitLength.isFinite
}
