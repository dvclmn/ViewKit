//
//  Popup+Action.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import BasePrimitives
import Foundation
//import SampleBuilder

public struct PopupAction: Sendable, Identifiable {
  public let id: UUID
  let title: String
  let action: @Sendable () -> Void

  public init(
    id: UUID = UUID(),
    title: String,
    action: @escaping @Sendable () -> Void
  ) {
    self.id = id
    self.title = title
    self.action = action
  }
}

public enum PopupActionPreset {
  case openInFinder(URL)
  case copyToClipboard(String)

  var title: String {
    switch self {
      case .openInFinder: "View in Finder"
      case .copyToClipboard: "Copy Text"
    }
  }
}
extension PopupAction {

  /// Will add a default title if none provided
  public static func preset(
    _ title: String? = nil,
    preset: PopupActionPreset
  ) -> Self {
    switch preset {
      case .openInFinder(let url):
        PopupAction(title: title ?? preset.title) {
          OpenInFinder.open(url)
        }
        
      case .copyToClipboard(let text):
        PopupAction(title: title ?? preset.title) {
          copyStringToClipboard(text)
        }
    }
  }
}

/// ```
/// @MainActor
/// private func displayPopup(popupMessage: PopupMessage) async {
///   let runAction = makeActionClosure(from: popupMessage.action) // /// always safe to call
///   let dismiss = makeDismissalClosure(from: popupMessage.dismissal)
///
///   // Wire these into your UI (e.g., button taps call runAction())
///   // Start dismissal behaviour when appropriate
///   dismiss()
/// }
/// ```
///
/// ```
/// func makeComposedAction(
///   from action: PopupAction?,
///   autoDismiss: @MainActor @escaping () -> Void
/// ) -> @Sendable () -> Void {
///   let userAction = makeActionClosure(from: action)
///   return {
///     // 1) analytics
///     print("Popup action triggered")
///     // 2) user-provided action
///     userAction()
///     // 3) optional dismissal
///     Task { @MainActor in autoDismiss() }
///   }
/// }
/// ```
extension Popup {
  /// Converts PopupMessage.action into a closure you can call uniformly.
  /// If there's no action, returns a no-op.
  func makeActionClosure(from action: PopupAction?) -> () -> Void {
    guard let action else { return {} }
    return action.action
  }
}
