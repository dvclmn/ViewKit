//
//  QuickPicker.swift
//  Components
//
//  Created by Dave Coleman on 18/1/2025.
//

import CoreTools
import SwiftUI

public struct QuickPicker<Item: Hashable & Identifiable>: View {

  @Environment(\.heightOverride) private var heightOverride

  let title: String
  @Binding var selection: Item

  /// The items representing what the Picker chooses from
  let sourceData: [Item]

  public init(
    title: String,
    selection: Binding<Item>,
    sourceData: [Item],
  ) {
    self.title = title
    self._selection = selection
    self.sourceData = sourceData
  }

  public var body: some View {

    Picker(title, selection: $selection) {
      ForEach(sourceData) { item in
        TextLabel(for: item).tag(item)
      }
    }
  }
}

extension QuickPicker {
  @ViewBuilder
  private func TextLabel(for item: Item) -> some View {
    Text(String(describing: item))
  }
}

extension QuickPicker where Item: CustomStringConvertible {
  @ViewBuilder
  private func TextLabel(for item: Item) -> some View {
    Text(item.description)
  }
}

extension QuickPicker where Item: RawRepresentable, Item.RawValue == String {
  @ViewBuilder
  private func TextLabel(for item: Item) -> some View {
    Text(item.rawValue.capitalized)
  }
}

extension QuickPicker where Item: LabeledItem {
  @ViewBuilder
  private func TextLabel(for item: Item) -> some View {
    MaybeLabel(item.label)
  }
}

extension QuickPicker where Item: CaseIterable {
  public init(
    title: String,
    selection: Binding<Item>,
  ) where Item.AllCases: RandomAccessCollection, Item.AllCases.Element == Item, Item.AllCases == [Item] {
    self.title = title
    self._selection = selection
    self.sourceData = Item.allCases
  }
}
