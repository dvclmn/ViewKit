//
//  QuickPicker.swift
//  Components
//
//  Created by Dave Coleman on 18/1/2025.
//


import SwiftUI
import SharedHelpers

public struct QuickPicker<Item: Pickable & Shortcuttable>: View {
  @Environment(\.explicitHeight) private var explicitHeight

  @Binding var item: Item
  let style: QuickPickerStyle
  let hasLabeledContentWrapper: Bool
  let areShortcutsEnabled: Bool
  let maxItems: Int?
  
  public init(
    item: Binding<Item>,
    style: QuickPickerStyle = .plain,
    hasLabeledContentWrapper: Bool = true,
    areShortcutsEnabled: Bool = false,
    maxItems: Int? = nil  // zero = no maximum
  ) {
    self._item = item
    self.style = style
    self.hasLabeledContentWrapper = hasLabeledContentWrapper
    self.areShortcutsEnabled = areShortcutsEnabled
    self.maxItems = maxItems
  }

  public var body: some View {

    switch style {
      case .plain:
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

      case .capsule:

        ItemScrollable(
          scrolledItem: $item,
          axis: .horizontal,
          showsIndicators: false
        ) { scrollableItem in
          MaybeLabel(item.label)
          //            .setIsSelected(item == scrollableItem)
          //            .font(.callout.weight(.medium))
        }

    }

  }
}

extension QuickPicker {
  @ViewBuilder
  func PickerContent() -> some View {
    Picker(Item.pickerLabel.text, selection: $item) {
      ForEach(Item.allCases.prefix(maxItems ?? 99)) { pickerItem in
        if areShortcutsEnabled, let shortcut = pickerItem.keyboardShortcut {
          MaybeLabel(pickerItem.label).tag(pickerItem)
            .keyboardShortcut(shortcut)
        } else {
          MaybeLabel(pickerItem.label).tag(pickerItem)
        }
      }
    }
    //    .labelsHidden()
    //    .fixedSize()
  }
}
