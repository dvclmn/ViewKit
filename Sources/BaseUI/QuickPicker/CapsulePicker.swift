//
//  CapsulePicker.swift
//  ViewKit
//
//  Created by Dave Coleman on 22/7/2026.
//

import CoreTools
import SwiftUI
import ViewTools

/// The capsule presentation used internally by ``QuickPicker``.
struct CapsulePicker<Item: LabeledItem & Hashable>: View {

  let title: String
  @Binding var selection: Item
  let sourceData: [Item]

  var body: some View {

    HStack(spacing: 0) {
      ForEach(Array(sourceData.enumerated()), id: \.element.id) { index, item in

        Button {
          select(item)
        } label: {
          CapsulePicker_ItemLabel(label: item.label, isSelected: itemIsSelected(item))
          //            .border(Color.green.opacity(0.1))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(itemIsSelected(item) ? .isSelected : [])

        if dividerIsShowing(for: item, index: index) {
          Divider()
            .frame(height: 20)
        }
        //        if index < sourceData.count - 1 {
        //          Divider()
        //            .frame(height: 20)
        //            .opacity(isDividerShowing(for: item, index: index) ? 0 : 1)
        //        }
      }
    }
    .padding(2)
    .background { Capsule().fill(.quaternary) }
    //    .accessibilityElement(children: .contain)
    //    .accessibilityLabel(title)
  }
}

extension CapsulePicker {

  private func itemIsSelected(_ item: Item) -> Bool {
    selection == item
  }

  private func dividerIsShowing(for item: Item, index: Int) -> Bool {
    guard index < sourceData.count - 1 else { return false }

    return !itemIsSelected(item)
      && selection != sourceData[index + 1]
  }

  private func select(_ item: Item) {
    guard selection != item else { return }

    //    withAnimation(reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 0.75)) {
    selection = item
    //    }
  }

}
