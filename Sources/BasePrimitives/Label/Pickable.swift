//
//  Pickable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/9/2025.
//

import Foundation

public protocol Pickable: LabeledItem {
//where Self: CaseIterable, Self.AllCases: RandomAccessCollection {

  /// A label that describes the purpose of the whole enum.
  /// E.g. "View Mode", or "Inspector Tab"
  static var pickerLabel: QuickLabel { get }
  func isSelected(current: Self) -> Bool
}

extension Pickable where Self: Equatable {
  public func isSelected(current: Self) -> Bool {
    return self == current
  }
}

extension Pickable {
  public static var pickerLabel: QuickLabel {
    let typeName = String(describing: Self.self)
    let words = typeName.camelCaseToWords
    return QuickLabel(words)
  }
}
