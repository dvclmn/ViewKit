//
//  Popup+Role.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import Foundation

public enum PopupDismissBehaviour: Equatable, Sendable {
  case automatic(TimeInterval, showsIndicator: Bool = false)
  case manual
  
  public var autoDismissDuration: TimeInterval? {
    guard case .automatic(let interval, _) = self else {
      return nil
    }
    return interval
  }
  public var shouldShowDismissTimingIndicator: Bool {
    guard case .automatic(_, let showsIndicator) = self else {
      return false
    }
    return showsIndicator
  }
}
