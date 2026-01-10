//
//  Text.LayoutKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/10/2025.
//

import SwiftUI

/// Note: This is an alias for `[Text.LayoutKey.AnchoredLayout]`

extension Text.LayoutKey.Value {
  public var lineCount: Int {
    return self.reduce(0) { partialResult, anchoredLayout -> Int in
      partialResult + anchoredLayout.layout.count
    }
  }
}
