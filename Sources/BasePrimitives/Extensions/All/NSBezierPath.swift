//
//  NSBezierPath.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

#if canImport(AppKit)
import AppKit

extension NSBezierPath {
  public func copied() -> NSBezierPath {
    return self.copy() as! NSBezierPath
  }
}
#endif