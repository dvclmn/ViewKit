//
//  QuickPicker.swift
//  Components
//
//  Created by Dave Coleman on 18/1/2025.
//

import SharedHelpers
import SwiftUI

public struct QuickPicker<RowContent: View, Item: Pickable & Shortcuttable>: View {
  public typealias PickerOutput = (Item, Bool) -> RowContent
  @Environment(\.explicitHeight) private var explicitHeight

  @Binding var item: Item
  let style: QuickPickerStyle
  let hasLabeledContentWrapper: Bool
  let areShortcutsEnabled: Bool
  let maxItems: Int?
  let rowContent: PickerOutput
  private let hasCustomContent: Bool

  public init(
    item: Binding<Item>,
    style: QuickPickerStyle = .plain,
    hasLabeledContentWrapper: Bool = true,
    areShortcutsEnabled: Bool = false,
    maxItems: Int? = nil,
    @ViewBuilder rowContent: @escaping PickerOutput
  ) {
    self._item = item
    self.style = style
    self.hasLabeledContentWrapper = hasLabeledContentWrapper
    self.areShortcutsEnabled = areShortcutsEnabled
    self.maxItems = maxItems
    self.rowContent = rowContent
    self.hasCustomContent = true
  }

  public init(
    item: Binding<Item>,
    style: QuickPickerStyle = .plain,
    hasLabeledContentWrapper: Bool = true,
    areShortcutsEnabled: Bool = false,
    maxItems: Int? = nil,
  ) where RowContent == EmptyView {
    self._item = item
    self.style = style
    self.hasLabeledContentWrapper = hasLabeledContentWrapper
    self.areShortcutsEnabled = areShortcutsEnabled
    self.maxItems = maxItems
    self.rowContent = { _, _ in EmptyView() }
    self.hasCustomContent = false

    //    self.init(
    //      item: item,
    //      style: style,
    //      hasLabeledContentWrapper: hasLabeledContentWrapper,
    //      areShortcutsEnabled: areShortcutsEnabled,
    //      maxItems: maxItems
    //    ) { _, _ in
    //      EmptyView()
    //    }

  }

  public var body: some View {

    Group {
      switch style {
        case .plain:
          PlainStyle()

        case .capsule:
          ItemScrollable(
            scrolledItem: $item,
            axis: .horizontal,
            showsIndicators: false
          ) { scrollableItem in
            MaybeLabel(item.label)
          }
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

      ForEach(Item.allCases.prefix(maxItems ?? Int.max)) { pickerItem in

        RowView(pickerItem) { hovering in
          if hasCustomContent {
            rowContent(pickerItem, hovering)
          } else {
//            Text("Shrim")
            MaybeLabel(pickerItem.label)
          }
        }
      }
    }
  }

  @ViewBuilder
  private func ViewName() -> some View {

  }
}
