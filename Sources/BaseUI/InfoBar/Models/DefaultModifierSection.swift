//
//  DefaultModifierSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools

public enum ModifiersSectionKey: InfoBarSectionKey {
  public static let title = "Modifiers"
}

extension InfoBarItem {

  package static func modifiersSection(_ modifiers: Modifiers?) -> InfoBarItem {
    InfoBarItem(
      sectionKey: InfoBarSectionID(ModifiersSectionKey.self),
      label: QuickLabel("Modifiers", symbol: "keyboard"),
      content: "Need to fix"
//        modifiers?.displayName(
//        elements: .icon,
//        separator: "",
//        emptyText: ""
//      ) ?? ""
    )
  }
}
