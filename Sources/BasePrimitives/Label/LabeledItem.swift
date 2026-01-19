//
//  LabeledItem.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/5/2025.
//

import Foundation

/// Previously conformed to `Equatable` and `Hashable`, have removed
/// for some flexibility over in DisplayString
public protocol LabeledItem: Identifiable {
//  associatedtype
  var id: Self.ID { get }
  var label: QuickLabel { get }
  var blurb: String? { get }
}

extension LabeledItem {
  public var blurb: String? { nil }
}

extension LabeledItem where Self: RawRepresentable, Self.RawValue == String {
  public var id: String { rawValue }
  public var label: QuickLabel { .init(rawValue.capitalized) }
  public var name: String { rawValue.capitalized }
}
