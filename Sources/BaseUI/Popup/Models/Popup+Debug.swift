//
//  Sample+Popup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/10/2025.
//

import Foundation

@MainActor
public enum PopupDebug {
  case popup(PopupMessage)
  case none

  /// If returns nil, then this should pass to the *actual*
  /// (non-debug) message
  public var message: PopupMessage? {
    switch self {
      case .popup(let message): message
      case .none: nil
    }
  }
}
