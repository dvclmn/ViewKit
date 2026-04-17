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
  let releaseDelay: Duration
  let releaseAction: (() -> Void)?

  @State private var task: Task<Void, Never>? = nil

  func body(content: Content) -> some View {
    content
      .onChange(of: trigger) { _, newTrigger in
        task?.cancel()
        let isTarget = newTrigger == target
        guard isTarget || releaseAction != nil else { return }
        let pendingDelay = isTarget ? delay : releaseDelay
        let pendingAction = isTarget ? action : releaseAction!
        task = Task {
          do {
            try await Task.sleep(for: pendingDelay)
            pendingAction()
          } catch {
            // Cancelled mid-delay — action intentionally skipped
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
    releaseDelay: Duration = .zero,
    perform action: @escaping () -> Void,
    onRelease releaseAction: (@escaping () -> Void) = {},
  ) -> some View {
    modifier(
      DelayedActionModifier(
        trigger: trigger,
        target: target,
        delay: delay,
        action: action,
        releaseDelay: releaseDelay,
        releaseAction: releaseAction,
      ))
  }
}
