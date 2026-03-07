//
//  ShortcutDisplayStyle.swift
//  BaseComponents
//
//  Created by Dave Coleman on 1/10/2025.
//


import SwiftUI
import BasePrimitives
import EnumMacros

extension EnvironmentValues {
  @Entry public var keyDisplayStyle: KeyboardElementDisplayStyle = .symbolLiteral
  @Entry public var modifierDisplayStyle: KeyboardElementDisplayStyle = .symbolLiteral
  @Entry public var shortcutLabelStyle: ShortcutLabelStyle = .alt
  @Entry public var isShowingShortcutHint: Bool = false
}

@CaseDetection
public enum ShortcutLabelStyle {
  case system
  case alt
}
