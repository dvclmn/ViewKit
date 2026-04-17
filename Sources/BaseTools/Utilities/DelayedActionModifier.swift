//
//  DelayedActionModifier.swift
//  BaseDemos
//
//  Created by Dave Coleman on 17/2/2026.
//

import SwiftUI

struct DelayedActionModifier<Trigger: Equatable>: ViewModifier {
  let trigger: Trigger
  let target: Trigger
  let delay: Duration
  let action: () -> Void

  @State private var task: Task<Void, Never>? = nil

  func body(content: Content) -> some View {
    content
      .onChange(of: trigger) { _, newTrigger in
        task?.cancel()
        if newTrigger == target {
          task = Task {
            do {
              try await Task.sleep(for: delay)
              action()
            } catch {
              // Cancelled — do nothing
            }
          }
        }
      }
      .onDisappear {
        task?.cancel()
      }
  }
}

extension View {
  /// Performs `action` after `trigger` holds equal to `target` for `delay`.
  public func onHoldDelay<Trigger: Equatable>(
    of trigger: Trigger,
    equals target: Trigger,
    delay: Duration = .seconds(0.5),
    perform action: @escaping () -> Void,
  ) -> some View {
    modifier(
      DelayedActionModifier(
        trigger: trigger,
        target: target,
        delay: delay,
        action: action
      )
    )
  }
}
