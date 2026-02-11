//
//  QuickPicker.swift
//  Components
//
//  Created by Dave Coleman on 18/1/2025.
//

import BasePrimitives
import SwiftUI

// See also a Picker variant with a `currentValueLabel`
//nonisolated public init<C>(sources: C, selection: KeyPath<C.Element, Binding<SelectionValue>>, @ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) where C : RandomAccessCollection
/// Note: ForEach automatically assigns a tag to the selection views using each option’s id. This is possible because Flavor conforms to the Identifiable protocol.

public struct QuickPicker<Item: Hashable & Identifiable & CustomStringConvertible>: View {
  //public struct QuickPicker<RowContent: View, Item>: View where Item: Pickable & Hashable {

  //  public typealias PickerOutput = (Item, Bool) -> RowContent
  @Environment(\.heightOverride) private var heightOverride

  //  @State private var sourceData: [Item]

  let title: String
  @Binding var selection: Item
  /// The items representing what the Picker chooses from
  let sourceData: [Item]

  //  let style: QuickPickerStyle
  //  let hasLabeledContentWrapper: Bool
  //  let areShortcutsEnabled: Bool
  //  let maxItems: Int?
  //  let rowContent: PickerOutput?

  public init(
    title: String,
    selection: Binding<Item>,
    sourceData: [Item],
    //    style: QuickPickerStyle = .plain,
    //    hasLabeledContentWrapper: Bool = false,
    //    areShortcutsEnabled: Bool = false,
    //    maxItems: Int? = nil,
    //    @ViewBuilder rowContent: @escaping PickerOutput = { _, _ in EmptyView() }
  ) {
    //  ) where RowContent == EmptyView {
    self.title = title
    self._selection = selection
    self.sourceData = sourceData
    //    self._allItems = State(initialValue: allItems)
    //    self.style = style
    //    self.hasLabeledContentWrapper = hasLabeledContentWrapper
    //    self.areShortcutsEnabled = areShortcutsEnabled
    //    self.maxItems = maxItems
    //    self.rowContent = rowContent
  }
  //  private let hasCustomContent: Bool

  public var body: some View {
    
    Picker(title, selection: $selection) {
      ForEach(sourceData) { item in
        Text(item.description)
      }
    }
//    currentValueLabel: {
//    }


//    Group {
//      switch style {
//        case .plain:
//          PlainStyle()
//
//        case .capsule:
//          Text("Not currently available")
//      //          ItemScrollable(
//      //            scrolledItem: $item,
//      //            axis: .horizontal,
//      //            showsIndicators: false
//      //          ) { scrollableItem in
//      //            MaybeLabel(item.label)
//      //          }
//      }
//    }
//    .environment(\.shortcutsEnabled, areShortcutsEnabled)
  }
}

extension QuickPicker {

//  @ViewBuilder
//  private func PlainStyle() -> some View {
//    if hasLabeledContentWrapper {
//      LabeledContent {
//        PickerContent()
//      } label: {
//        MaybeLabel(Item.pickerLabel)
//          .foregroundStyle(.secondary)
//      }
//    } else {
//      PickerContent()
//    }
//  }

//  @ViewBuilder
//  func PickerContent() -> some View {
//    Picker(Item.pickerLabel.text, selection: $item) {
//
//      ForEach(allItems) { pickerItem in
//
//        //        RowView(pickerItem) { hovering in
//        //          if rowContent != nil {
//        //            rowContent?(pickerItem, hovering)
//        //          } else {
//
//        //            VStack {
//        //              Text("Item Type: \(String(describing: pickerItem.self))")
//        //              Text("All Items Type: \(String(describing: allItems.self))")
//        //            }
//        MaybeLabel(pickerItem.label).tag(pickerItem)
//        //          }
//        //        }
//      }
//    }
//  }
}

extension QuickPicker where Item: CaseIterable, Item.AllCases == [Item] {
  public init(
    title: String,
    selection: Binding<Item>,
//    item: Binding<Item>,
//    style: QuickPickerStyle = .plain,
//    hasLabeledContentWrapper: Bool = false,
//    areShortcutsEnabled: Bool = false,
//    maxItems: Int? = nil,
    //    @ViewBuilder rowContent: @escaping PickerOutput = { _, _ in EmptyView() }
  ) {
    self.title = title
    self._selection = selection
    self.sourceData = Item.allCases
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
