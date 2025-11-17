//
//  NSTextCheckingResult.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

import Foundation

extension NSTextCheckingResult {
  @available(macOS 10.13, *)
  public func range(named name: String) -> NSRange {
//    if # {
      return self.range(withName: name)
//    } else {
      // older fallback: try to map index -> name (not implemented here)
//      return NSRange(location: NSNotFound, length: 0)
//    }
  }
}
