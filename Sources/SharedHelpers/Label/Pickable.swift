//
//  Pickable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/9/2025.
//

import Foundation

public protocol Pickable: LabeledItem {

  /// A label that describes the purpose of the whole enum.
  /// E.g. "View Mode", or "Inspector Tab"
  static var pickerLabel: QuickLabel { get }
}

extension Pickable where Self: CaseIterable, Self.AllCases == [Self] {
  public var allItems: [Self] { Self.allCases }
}

extension Pickable {
  /// Produces a rough default Picker label
  public static var pickerLabel: QuickLabel {
    let typeName = String(describing: Self.self)
    let words = typeName.camelCaseToWords
    return QuickLabel(words)
  }
}
