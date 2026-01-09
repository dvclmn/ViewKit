//
//  File.swift
//
//
//  Created by Dave Coleman on 24/6/2024.
//


import SwiftUI
import SharedHelpers


extension LabelStyle where Self == ShortcutLabel {
  public static var shortcut: Self { Self(shortcut: nil, displayStyle: .alt) }

  public static func shortcut(
    _ shortcut: KeyboardShortcut?,
    displayStyle: ShortcutLabelStyle? = .alt
  ) -> Self {
    Self(
      shortcut: shortcut,
      displayStyle: displayStyle
    )
  }
}


public struct ShortcutLabel: LabelStyle {
  @Environment(\.keyDisplayStyle) private var keyDisplayStyle
  @Environment(\.modifierDisplayStyle) private var modifierDisplayStyle
  @Environment(\.shortcutLabelStyle) private var shortcutLabelStyle
  @Environment(\.isShowingShortcutHint) private var isShowingShortcutHint
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.keyboardShortcut) private var envShortcut

  let shortcut: KeyboardShortcut?
  let displayStyle: ShortcutLabelStyle?

  public init(
    shortcut: KeyboardShortcut?,
    displayStyle: ShortcutLabelStyle?
  ) {
    self.shortcut = shortcut
    self.displayStyle = displayStyle
  }

  public func makeBody(configuration: Configuration) -> some View {

    HStack(spacing: Styles.sizeTiny.bump) {
      Label(configuration)
        .labelStyle(.base)
        .frame(maxWidth: style.isAlt ? nil : .infinity, alignment: .leading)
        .environment(\.labelDisplay, style.isAlt ? .titleOnly : .titleAndIcon)

      if let shortcut = shortcut ?? envShortcut {
        Text(
          shortcut.displayString(
            keyStyle: keyDisplayStyle,
            modifierStyle: modifierDisplayStyle
          )
        )
        .foregroundStyle(.primary.opacity(0.9))
      }
    }
    .opacity(isEnabled ? 1.0 : 0.35)
    .font(.callout)
    .symbolVariant(.fill)
    .symbolRenderingMode(.hierarchical)
  }
}


extension ShortcutLabel {
  private var style: ShortcutLabelStyle {
    return displayStyle ?? shortcutLabelStyle
  }
}
