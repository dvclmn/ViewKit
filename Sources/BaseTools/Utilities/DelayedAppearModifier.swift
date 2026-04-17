//
//  DelayedAppearModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/4/2026.
//

import SwiftUI

struct DelayedAppearModifier: ViewModifier {
  let delay: Duration
  let action: () -> Void
  
  @State private var task: Task<Void, Never>? = nil
  
  func body(content: Content) -> some View {
    content
      .onAppear {
        task?.cancel()
        task = Task {
          try? await Task.sleep(for: delay)
          action()
        }
      }
      .onDisappear {
        task?.cancel()
      }
  }
}

extension View {
  public func onAppearDelay(
    _ delay: Duration = .seconds(0.5),
    perform action: @escaping () -> Void
  ) -> some View {
    modifier(DelayedAppearModifier(delay: delay, action: action))
  }
}
