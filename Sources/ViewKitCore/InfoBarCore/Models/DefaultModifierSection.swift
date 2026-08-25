//
//  DefaultModifierSection.swift
//  ViewKit
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import ViewTools

public enum ModifiersSectionKey: InfoBarSectionKey {
  public static let title = "Modifiers"
}

extension InfoBarItem {

  package static func modifiersItem(_ modifiers: Modifiers?) -> InfoBarItem {
    InfoBarItem(
      label: LabelDescriptor("Modifiers", symbol: "keyboard"),
      content: "Need to fix"
    )
  }
}
