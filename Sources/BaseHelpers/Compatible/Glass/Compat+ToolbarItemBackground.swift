//
//  Compat+ToolbarItemBackground.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import SwiftUI

extension ToolbarContent {
  @ToolbarContentBuilder
  public func backgroundVisibilityCompatible(_ visibility: Visibility) -> some ToolbarContent {
    if #available(macOS 26, iOS 26, *) {
      self.sharedBackgroundVisibility(visibility)
    } else {
      self
    }
  }
}
