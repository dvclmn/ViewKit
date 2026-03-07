//
//  PickerRowView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/11/2025.
//

import BasePrimitives
import SwiftUI

extension QuickPicker {
  struct RowView<Content: View>: View {
    @Environment(\.shortcutsEnabled) private var areShortcutsEnabled
    @State private var isHovering: Bool = false

    let item: Item
    let content: (Bool) -> Content

    init(
      _ item: Item,
      @ViewBuilder content: @escaping (Bool) -> Content
    ) {
      self.item = item
      self.content = content
    }

    var body: some View {

      content(isHovering)
        .tag(item)
        //        .keyboardShortcut(shortcut)

        .onHover { hovering in
          self.isHovering = hovering
        }
    }
  }
}
extension QuickPicker.RowView {
  #warning("Need to fix Shortcuttable back up")
  //  private var shortcut: KeyboardShortcut? {
  //    guard areShortcutsEnabled else { return nil }
  //    return item.keyboardShortcut
  //  }
}
