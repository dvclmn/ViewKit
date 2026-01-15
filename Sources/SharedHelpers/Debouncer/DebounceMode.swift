//
//  ShouldDebounce.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/7/2025.
//

import SwiftUI

public enum DebounceMode {
  case noDebounce
  case debounce(TimeInterval = 0.2)
}

extension DebounceMode {
  public func createDebouncer() -> State<AsyncDebouncer?> {
    switch self {
      case .noDebounce: State(initialValue: nil)
      case .debounce(let interval): State(initialValue: AsyncDebouncer(interval: interval))
    }
  }
}
