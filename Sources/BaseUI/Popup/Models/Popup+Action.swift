//
//  Popup+Action.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import Foundation

public struct PopupAction {
  let title: String
  let action: () -> Void
  
  public init(title: String, action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }
}
