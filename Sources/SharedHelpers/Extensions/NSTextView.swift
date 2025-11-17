//
//  NSTextView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension NSTextView {
  public func setInsets(_ size: CGSize) {
    self.textContainer?.lineFragmentPadding = size.width
    self.textContainerInset = NSSize(
      width: 0,
      height: size.height
    )
  }
}


