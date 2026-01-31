//
//  FrameRate.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import Foundation

public enum FrameRate: Int, CaseIterable, Identifiable {
  case fps8 = 8
  case unlocked = 0
  case fps15 = 15
  case fps24 = 24
  case fps30 = 30
  case fps60 = 60
  case fps120 = 120
  
  /// System determines appropriate update interval
}

extension FrameRate {
  public var id: Int { rawValue }
  
  public var isUnlocked: Bool { self == .unlocked }
  
  public var rate: TimeInterval? {
    switch self {
      case .unlocked: nil
      default: 1 / TimeInterval(rawValue)
    }
  }
}
