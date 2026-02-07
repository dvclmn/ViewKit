//
//  QuickPicker.swift
//  Components
//
//  Created by Dave Coleman on 18/1/2025.
//

import BasePrimitives
import SwiftUI

public struct QuickPicker<RowContent: View, Item>: View where Item: Pickable & Hashable {

  public typealias PickerOutput = (Item, Bool) -> RowContent
  @Environment(\.heightOverride) private var heightOverride

  @State private var allItems: [Item]
//  let allItems: [Item]

  @Binding var item: Item
  let style: QuickPickerStyle
  let hasLabeledContentWrapper: Bool
  let areShortcutsEnabled: Bool
  let maxItems: Int?
  let rowContent: PickerOutput?

  public init(
    item: Binding<Item>,
    allItems: [Item],
    style: QuickPickerStyle = .plain,
    hasLabeledContentWrapper: Bool = false,
    areShortcutsEnabled: Bool = false,
    maxItems: Int? = nil,
    @ViewBuilder rowContent: @escaping PickerOutput = { _, _ in EmptyView() }
  ) where RowContent == EmptyView {
    self._item = item
    self._allItems = State(initialValue: allItems)
    self.style = style
    self.hasLabeledContentWrapper = hasLabeledContentWrapper
    self.areShortcutsEnabled = areShortcutsEnabled
    self.maxItems = maxItems
    self.rowContent = rowContent
  }
  //  private let hasCustomContent: Bool

  public var body: some View {

    Group {
      switch style {
        case .plain:
          PlainStyle()

        case .capsule:
          Text("Not currently available")
      //          ItemScrollable(
      //            scrolledItem: $item,
      //            axis: .horizontal,
      //            showsIndicators: false
      //          ) { scrollableItem in
      //            MaybeLabel(item.label)
      //          }
      }
    }
    .environment(\.shortcutsEnabled, areShortcutsEnabled)
  }
}

extension QuickPicker {

  @ViewBuilder
  private func PlainStyle() -> some View {
    if hasLabeledContentWrapper {
      LabeledContent {
        PickerContent()
      } label: {
        MaybeLabel(Item.pickerLabel)
          .foregroundStyle(.secondary)
      }
    } else {
      PickerContent()
    }
  }

  @ViewBuilder
  func PickerContent() -> some View {
    Picker(Item.pickerLabel.text, selection: $item) {

      ForEach(allItems) { pickerItem in
        
//        RowView(pickerItem) { hovering in
//          if rowContent != nil {
//            rowContent?(pickerItem, hovering)
//          } else {
            
//            VStack {
//              Text("Item Type: \(String(describing: pickerItem.self))")
//              Text("All Items Type: \(String(describing: allItems.self))")
//            }
            MaybeLabel(pickerItem.label).tag(pickerItem)
//          }
//        }
      }
    }
  }
}

extension QuickPicker where Item: CaseIterable, Item.AllCases == [Item] {
  public init(
    item: Binding<Item>,
    style: QuickPickerStyle = .plain,
    hasLabeledContentWrapper: Bool = false,
    areShortcutsEnabled: Bool = false,
    maxItems: Int? = nil,
    @ViewBuilder rowContent: @escaping PickerOutput = { _, _ in EmptyView() }
  ) where RowContent == EmptyView {
    self._item = item

    /// This init is able to populate `allItems` automatically,
    /// using `CaseIterable`'s `allCases`.
    self._allItems = State(initialValue: Item.allCases)

    self.style = style
    self.hasLabeledContentWrapper = hasLabeledContentWrapper
    self.areShortcutsEnabled = areShortcutsEnabled
    self.maxItems = maxItems
    self.rowContent = rowContent
  }

}

//extension QuickPicker {
//  public init?(
//    item: Binding<Item>?,
//    style: QuickPickerStyle = .plain,
//    hasLabeledContentWrapper: Bool = false,
//    areShortcutsEnabled: Bool = false,
//    maxItems: Int? = nil,
//    @ViewBuilder rowContent: @escaping PickerOutput = { _, _ in EmptyView() }
//  ) where RowContent == EmptyView {
//    guard let item else { return nil }
//    self.init(
//      item: item,
//      style: style,
//      hasLabeledContentWrapper: hasLabeledContentWrapper,
//      areShortcutsEnabled: areShortcutsEnabled,
//      maxItems: maxItems,
//      rowContent: rowContent
//    )
//  }
//}

// MARK: - Initialisers
//extension QuickPicker where RowContent == EmptyView {

//  public init

//  public init(
//    item: Binding<Item>,
//    style: QuickPickerStyle = .plain,
//    hasLabeledContentWrapper: Bool = false,
//    areShortcutsEnabled: Bool = false,
//    maxItems: Int? = nil,
//    @ViewBuilder rowContent: @escaping PickerOutput? = nil
//  ) {
//    self._item = item
//    self.style = style
//    self.hasLabeledContentWrapper = hasLabeledContentWrapper
//    self.areShortcutsEnabled = areShortcutsEnabled
//    self.maxItems = maxItems
//    self.rowContent = rowContent
//    self.hasCustomContent = true
//  }

//  public init(
//    item: Binding<Item>,
//    style: QuickPickerStyle = .plain,
//    hasLabeledContentWrapper: Bool = false,
//    areShortcutsEnabled: Bool = false,
//    maxItems: Int? = nil,
//  ) where RowContent == EmptyView {
//    self._item = item
//    self.style = style
//    self.hasLabeledContentWrapper = hasLabeledContentWrapper
//    self.areShortcutsEnabled = areShortcutsEnabled
//    self.maxItems = maxItems
//    self.rowContent = { _, _ in EmptyView() }
//    self.hasCustomContent = false
//
//    //    self.init(
//    //      item: item,
//    //      style: style,
//    //      hasLabeledContentWrapper: hasLabeledContentWrapper,
//    //      areShortcutsEnabled: areShortcutsEnabled,
//    //      maxItems: maxItems
//    //    ) { _, _ in
//    //      EmptyView()
//    //    }
//
//  }

//}
