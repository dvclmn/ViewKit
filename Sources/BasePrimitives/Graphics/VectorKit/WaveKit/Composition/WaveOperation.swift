//
//  WaveOperation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

public enum WaveOperation: String, Codable, Sendable, Hashable {
  case addToBase
  case addToCurrent
  case scaleBaseByOnePlusOffset
  case scaleCurrentByOnePlusOffset
  case addBaseTimesOffset
}

extension WaveOperation {
  /// Note: Sanitisation (such as clamping) happens later
  @inlinable
  public func apply(
    base: Double,
    current: Double,
    offset: Double
  ) -> Double {
    switch self {
      case .addToBase: base + offset
      case .addToCurrent: current + offset
      case .scaleBaseByOnePlusOffset: base * (1 + offset)
      case .scaleCurrentByOnePlusOffset: current * (1 + offset)
      case .addBaseTimesOffset: base + (base * offset)
    }
  }
}
