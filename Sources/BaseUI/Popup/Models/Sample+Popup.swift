//
//  Sample+Popup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/10/2025.
//

import Foundation

@MainActor
public enum PopupDebug {
  case example(Example = .example01)
  case custom(PopupMessage)
  case none
  
  /// If returns nil, then this should pass to the *actual*
  /// (non-debug) message
  public var message: PopupMessage? {
    switch self {
      case .example(let example): example.value
      case .custom(let message): message
      case .none: nil
    }
  }
}

extension PopupDebug {
  public enum Example {
    case example01
    case example02
    
    @MainActor
    public var value: PopupMessage {
      switch self {
        case .example01: PopupMessage.example01
        case .example02: PopupMessage.example02
      }
    }
  }
}
