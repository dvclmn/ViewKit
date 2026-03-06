//
//  Ext+NSColor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit

extension NSColor {
  public func opacity(_ opacity: CGFloat) -> NSColor {
    withAlphaComponent(opacity)
  }
}
