//
//  DefaultModifierSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

//import InteractionKit
import BasePrimitives

public enum ModifiersSectionKey: InfoBarSectionKey {
  public static let title = "Modifiers"
}

extension InfoBarItem {

  package static func modifiersSection(_ modifiers: Modifiers?) -> InfoBarItem {
    InfoBarItem(
      section: ModifiersSectionKey.self,
      label: QuickLabel("Modifiers", symbol: "keyboard"),
      content: "Need to fix"
    )
  }
}
