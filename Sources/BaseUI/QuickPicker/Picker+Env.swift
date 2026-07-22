//
//  Picker+Env.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/11/2025.
//

import SwiftUI

extension EnvironmentValues {
  @Entry var shortcutsEnabled: Bool = false
  @Entry var quickPickerStyle: QuickPickerStyle = .plain
}

public extension View {
  /// Sets the presentation style used by descendant ``QuickPicker`` views.
  func quickPickerStyle(_ style: QuickPickerStyle) -> some View {
    environment(\.quickPickerStyle, style)
  }
}
