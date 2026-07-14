//
//  CardGridSection.swift
//  ViewKit
//
//  Created by Dave Coleman on 14/7/2026.
//

import CoreTools

/// A prepared, labelled section of items displayed by ``CardGrid``.
///
/// Create sections where the data changes, then pass them to
/// ``CardGrid/init(sections:alignment:cardSize:pinnedViews:content:)``. This
/// keeps grouping work out of the grid's view body and makes the caller's
/// section order explicit.
public struct CardGridSection<Item: LabeledItem & Equatable>: Identifiable {
  
  /// The stable identity for this section.
  public let id: AnyHashable

  /// The label displayed in the section header.
  public let label: LabelDescriptor

  /// The items displayed in this section, in their source order.
  public let items: [Item]

  /// Creates a section with an explicit identity and header label.
  public init<ID: Hashable>(
    id: ID,
    label: LabelDescriptor,
    items: [Item],
  ) {
    self.id = AnyHashable(id)
    self.label = label
    self.items = items
  }

  /// Creates a section whose identity and label come from its group value.
  public init<Group>(
    group: Group,
    items: [Item],
  ) where Group: Hashable & LabeledItem {
    self.init(id: group, label: group.label, items: items)
  }

  /// Groups items into labelled sections without sorting their contents.
  ///
  /// Items retain their input order. `order` is honoured first; groups not
  /// present in `order` then follow their first occurrence in `items`. Empty
  /// groups are omitted.
  public static func grouped<Group>(
    _ items: [Item],
    by groupPath: KeyPath<Item, Group>,
    order: [Group] = [],
  ) -> [Self] where Group: Hashable & LabeledItem {
    let itemsByGroup = Dictionary(grouping: items) { item in
      item[keyPath: groupPath]
    }

    var orderedGroups: [Group] = []
    var seenGroups: Set<Group> = []

    for group in order where seenGroups.insert(group).inserted {
      guard itemsByGroup[group] != nil else { continue }
      orderedGroups.append(group)
    }

    for item in items {
      let group = item[keyPath: groupPath]
      guard seenGroups.insert(group).inserted else { continue }
      orderedGroups.append(group)
    }

    return orderedGroups.compactMap { group in
      guard let items = itemsByGroup[group] else { return nil }
      return Self(group: group, items: items)
    }
  }
}
