//
//  InactivityModifier.swift
//  BaseTools
//
//  Created by Dave Coleman on 11/3/2026.
//

import SwiftUI

/// A view modifier that performs an action after a period of inactivity,
/// where inactivity is defined as no changes to a provided Equatable trigger value.
struct InactivityModifier<Trigger: Equatable>: ViewModifier {
  let trigger: Trigger
  let timeout: Duration
  let action: () -> Void

  @State private var task: Task<Void, Never>? = nil

  func body(content: Content) -> some View {
    content
      .task(id: trigger) {
        /// Reset the timer whenever the trigger changes
        task?.cancel()
        let delay = timeout
        task = Task { [delay] in
          try? await Task.sleep(for: delay)
          guard !Task.isCancelled else { return }
          action()
        }
      }
      .onDisappear {
        task?.cancel()
      }
  }
}

extension View {
  /// Performs `action` after `timeout` if `trigger` hasn't changed within that time.
  public func onInactivity<Trigger: Equatable>(
    of trigger: Trigger,
    timeout: Duration,
    perform action: @escaping () -> Void
  ) -> some View {
    modifier(InactivityModifier(trigger: trigger, timeout: timeout, action: action))
  }
}
