//
//  Popup+Role.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/2/2026.
//

import Foundation
//import SampleBuilder

//@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
public enum PopupDismissBehaviour: Equatable, Sendable {
  /// Dismisses a short, informational popup after the supplied interval.
  ///
  /// Prefer ``manual`` when a message describes an error, contains an action, or may take longer
  /// than the interval to read. Automatic popups always remain explicitly dismissible.
  case automatic(TimeInterval = 4, showsIndicator: Bool = false)

  /// Keeps the popup visible until the user dismisses it or another popup replaces it.
  case manual
  
  public var autoDismissDuration: TimeInterval? {
    guard case .automatic(let interval, _) = self else {
      return nil
    }
    guard interval.isFinite else { return nil }
    return max(0, interval)
  }
  public var shouldShowDismissTimingIndicator: Bool {
    guard case .automatic(_, let showsIndicator) = self else {
      return false
    }
    return showsIndicator
  }
}
