//
//  GroupedView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 30/8/2025.
//

import SwiftUI

public struct GroupedView<Content: View, Item: Identifiable>: View {
  //  @Environment(\.sectionNameTransform) private var sectionNameTransform
  @Environment(\.sectionHeaderColour) private var sectionHeaderColour
  let data: [Item]
  let keyForValue: ((Item) -> String)?
  let sectionNameTransform: (String) -> String
  let content: (Item) -> Content

  public init(
    data: [Item],
    groupedBy keyForValue: @escaping (Item) -> String,
    sectionNameTransform: @escaping (String) -> String = { $0 },
    @ViewBuilder content: @escaping (Item) -> Content,
  ) {

    //  public init(
    //    data: [Item],
    //    groupedBy keyForValue: @escaping (Item) -> String,
    //    @ViewBuilder content: @escaping (Item) -> Content
    //  ) {
    self.data = data
    self.keyForValue = keyForValue
    self.sectionNameTransform = sectionNameTransform
    self.content = content
  }

  public init(
    data: [Item],
    groupedBy groupPath: KeyPath<Item, String>? = nil,
    sectionNameTransform: @escaping (String) -> String = { $0 },
    @ViewBuilder content: @escaping (Item) -> Content,
  ) {
    self.data = data

    if let groupPath {
      self.keyForValue = { $0[keyPath: groupPath] }
    } else {
      self.keyForValue = nil
    }
    self.sectionNameTransform = sectionNameTransform
    self.content = content
  }

  public var body: some View {

    if let sections = sections() {

      ForEach(sections, id: \.key) { key, sectionedItems in
        Section {
          ForEach(sectionedItems) { item in
            content(item)
          }

        } header: {
          Text(sectionNameTransform(key))
            .fontWeight(.semibold)
            .foregroundStyle(sectionHeaderColour ?? AnyShapeStyle(.secondary.opacity(0.7)))
        }  // END section
      }  // END grouped swatches loop

    } else {
      ForEach(data) { item in
        content(item)
      }
    }
  }
}
extension GroupedView {

  private func sections() -> [ItemGroup<Item>.Element]? {

    guard let keyForValue else { return nil }
    let grouped: ItemGroup<Item> = Dictionary(grouping: data, by: keyForValue)
    let sortedSection = grouped.sorted(by: \.key)
    return sortedSection

  }
}
