//
//  ActivityDescribing.swift
//  BaseHelpers
//
//  Created by Assistant on 11/3/2026.
//

import Foundation

/// A tiny protocol for types that want a shared "active"/"idle" label mapping.
public protocol ActivityDescribing {}

public extension ActivityDescribing {
  /// Returns a short label for an activity flag.
  @inlinable
  func activityLabel(_ isActive: Bool) -> String { isActive ? "active" : "idle" }
}
