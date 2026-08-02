//
//  ToggleInspectorButton.swift
//  ViewKit
//
//  Created by Dave Coleman on 2/8/2026.
//

import SwiftUI

/// This can be added both to a Toolbar and a MenuCommands view
///
/// Also use ToolKit's `isInspectorPresented` Env value
/// (this example assumes use of Point-Free's Sharing library)
/// ```
/// .environment(
///   \.isInspectorPresented,
///   Binding(store.$preferences.isInspectorPresented)
/// )
/// ```
/// MenuCommands example:
/// ```
/// CommandGroup(after: .toolbar) {
///   ToggleInspectorButton(
///     isInspectorPresented: $store.preferences.isInspectorPresented
///   )
///     .keyboardShortcut("i", modifiers: [.control, .command])
/// }
/// ```

public struct ToggleInspectorButton: View {
  @Binding var isInspectorPresented: Bool

  public init(isPresented: Binding<Bool>) {
    self._isInspectorPresented = isPresented
  }
  public var body: some View {
    Toggle(isOn: $isInspectorPresented) {
      Label("Show Inspector", systemImage: "sidebar.trailing")
    }
    .tint(.clear)
  }
}
extension ToggleInspectorButton {
  public static let shortcut: KeyboardShortcut = .init("i", modifiers: [.control, .command])
}
