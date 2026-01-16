//
//  PointerHide.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/5/2025.
//

#if canImport(AppKit)
import AppKit
import SwiftUI

public struct PointerHideModifier: ViewModifier {

  let behaviour: PointerBehaviour
  let newPosition: CGPoint?
  
  public init(behaviour: PointerBehaviour, newPosition: CGPoint? = nil) {
    self.behaviour = behaviour
    self.newPosition = newPosition
  }
  
  public func body(content: Content) -> some View {
    content
      .task(id: behaviour) {
        // Apply requested behaviours when the task starts
        await MainActor.run {
          if behaviour.contains(.hide) {
            NSCursor.hide()
          }
          if behaviour.contains(.lock) {
            // Arrest pointer (0 = false)
            CGAssociateMouseAndMouseCursorPosition(0)
          }
          if let newPosition {
            CGWarpMouseCursorPosition(newPosition)
          }
        }
      }
      .onDisappear {
        // On disappear, ensure we restore state
        restorePointerState()
      }
      .onChange(of: behaviour) { _, _ in
        // When behaviour changes, restore then re-apply new behaviour to keep stacks balanced
        restorePointerState()
      }
  }
  
  @MainActor
  private func restorePointerState() {
    // Unlock if previously locked
    if behaviour.contains(.lock) {
      CGAssociateMouseAndMouseCursorPosition(1)
    }
    // Unhide as many times as we might have hidden. Using one unhide here relies on balanced usage at call-sites.
    if behaviour.contains(.hide) {
      NSCursor.unhide()
      NSCursor.arrow.set()
    }
  }
}

extension View {
  /// Apply pointer behaviour(s): hide, lock, or both. Optionally warp to a new position.
  public func pointer(behaviour: PointerBehaviour = .all, newPosition: CGPoint? = nil) -> some View {
    self.modifier(PointerHideModifier(behaviour: behaviour, newPosition: newPosition))
  }

  /// Convenience: hide only
  public func pointerHide(_ hidden: Bool = true) -> some View {
    if hidden {
      return self.modifier(PointerHideModifier(behaviour: [.hide], newPosition: nil))
    } else {
      return self
    }
  }

  /// Convenience: lock only, with optional warp
  public func pointerLock(_ locked: Bool = true, to newPosition: CGPoint? = nil) -> some View {
    if locked {
      return self.modifier(PointerHideModifier(behaviour: [.lock], newPosition: newPosition))
    } else {
      return self
    }
  }
}
#endif

public struct PointerBehaviour: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int
  
  public static let hide = Self(rawValue: 1 << 0)
  public static let lock = Self(rawValue: 1 << 1)
  public static let all: Self = [.hide, .lock]
}
