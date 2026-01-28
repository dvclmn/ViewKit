//
//  NamedItem.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

// MARK: - Name
/// Indicates that the item has a `name` property, and so can
/// have a label synthesised automically for it.
/// See ``IconItem`` for both name and icon.
public protocol NamedItem {
  var name: String { get }
}

// MARK: - Icon
/// Indicates that the item has an `icon` property, and so can
/// have a label synthesised automically for it
public protocol IconItem {
  var icon: IconLiteral { get }
}

extension LabeledItem where Self: NamedItem, Self: RawRepresentable, Self.RawValue == String {
  public var label: QuickLabel { .init(name) }
}

extension LabeledItem where Self: NamedItem & IconItem {
  public var label: QuickLabel { .init(name, icon: icon) }
}
