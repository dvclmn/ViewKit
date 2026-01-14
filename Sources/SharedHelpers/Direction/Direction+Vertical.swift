//
//  Direction+Vertical.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import Foundation
import EnumMacros

extension Direction {
  @CaseDetection
  public enum Vertical {
    case up
    case down
    
    public var opposite: Self { isUp ? .down : .up }
  }
}
