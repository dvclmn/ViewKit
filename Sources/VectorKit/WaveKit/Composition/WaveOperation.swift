//
//  WaveOperation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

public enum WaveOperation: String, Codable, Sendable, Hashable {
  /// current = base + offset
  case addToBase
  
  /// current = current + offset  (rare, but sometimes you want cumulative layering)
  case addToCurrent
  
  /// current = base * (1 + offset)
  case scaleBaseByOnePlusOffset
  
  /// current = current * (1 + offset)
  case scaleCurrentByOnePlusOffset
  
  /// current = base + (base * offset)  (same as scaleBaseByOnePlusOffset, but explicit)
  case addBaseTimesOffset
}

extension WaveOperation {
  @inlinable
  public func apply(base: Double, current: Double, offset: Double) -> Double {
    switch self {
      case .addToBase: base + offset
      case .addToCurrent: current + offset
      case .scaleBaseByOnePlusOffset: base * (1 + offset)
      case .scaleCurrentByOnePlusOffset: current * (1 + offset)
      case .addBaseTimesOffset: base + (base * offset)
    }
  }
}
