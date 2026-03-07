//
//  MultiItemView.swift
//  Components
//
//  Created by Dave Coleman on 25/2/2025.
//

import BasePrimitives
import SwiftUI

public struct MultiItemView<
  DataContent: View, Additional: View, Data: Collection & ExpressibleByArrayLiteral
>: View
where Data.Element: Identifiable, Data.Element.ID: Hashable {

  public typealias ItemID = Data.Element.ID
  public typealias Output = (Data.Element) -> DataContent
  public typealias AdditionalContent = (ItemState) -> Additional

  @Environment(\.controlSize) private var controlSize

  let itemDisplayName: String
  let selected: Set<ItemID>
  let data: Data
  let content: Output
  let additionalContent: AdditionalContent

  public init(
    _ itemDisplayName: String,
    selected: Set<ItemID>,
    data: Data,
    @ViewBuilder additionalContent: @escaping AdditionalContent,
    @ViewBuilder content: @escaping Output,
  ) {
    self.itemDisplayName = itemDisplayName
    self.selected = selected
    self.data = data
    self.additionalContent = additionalContent
    self.content = content
  }

  public var body: some View {

    /// View for a single, matching Item
    if selected.count == 1, let firstMatchingItemID = selected.first {

      ItemIfFound(firstMatchingItemID)

      /// For multiple Items selected
    } else if selected.count > 1 {
      StateView(
        pluralise(
          itemDisplayName,
          count: selected.count,
          countStrategy: .showCount()
        ) + " Selected"
      )

      /// Otherwise, show UI for empty state
    } else {
      EmptyState()
    }
  }
}
extension MultiItemView {
  @ViewBuilder
  private func ItemIfFound(_ itemID: ItemID) -> some View {
    if let item = data.first(where: { $0.id == itemID }) {
      content(item)

    } else {
      StateView("Couldn't find \(itemDisplayName) with that ID.")
    }
  }

  @ViewBuilder
  private func EmptyState() -> some View {
    /// Either there's no data
    if data.isEmpty {
      StateView("No \(itemDisplayName)s to display", icon: .emoji("🕳️")) {
        additionalContent(.emptyData)
      }
    } else {
      /// Or there is, but  nothing is selected
      StateView("No \(itemDisplayName)s selected", icon: .emoji("🛼")) {
        additionalContent(.noneSelected)
      }
    }
  }
}

public enum ItemState {
  //  case multipleSelected
  //  case singleSelected
  case noneSelected
  case emptyData
}

extension MultiItemView where Additional == EmptyView {

  public init(
    _ itemDisplayName: String,
    selected: Set<ItemID>,
    data: Data,
    //    @ViewBuilder additionalContent: @escaping AdditionalContent = { _ in EmptyView() },
    @ViewBuilder content: @escaping Output,
  ) {
    self.itemDisplayName = itemDisplayName
    self.selected = selected
    self.data = data
    self.content = content
    self.additionalContent = { _ in EmptyView() }
  }
}
