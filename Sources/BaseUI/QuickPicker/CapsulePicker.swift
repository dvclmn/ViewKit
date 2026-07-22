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
  //  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  let title: String
  @Binding var selection: Item
  let sourceData: [Item]

  var body: some View {

    HStack(spacing: 0) {
      ForEach(Array(sourceData.enumerated()), id: \.element.id) { index, item in

        Button {
          select(item)
        } label: {
          CapsulePicker_ItemLabel(label: item.label, isSelected: item == selection)
          //            .border(Color.green.opacity(0.1))
        }
        .buttonStyle(.plain)
        //        .accessibilityAddTraits(isSelected(item) ? .isSelected : [])

        if index < sourceData.count - 1 {
          Divider()
            .frame(height: 20)
          //            .opacity((selection == item || selection == sourceData[index + 1]) ? 0 : 0.5)
        }
      }
    }
    .padding(2)
    .background { Capsule().fill(.quaternary) }
    //    .accessibilityElement(children: .contain)
    //    .accessibilityLabel(title)
  }
}

extension CapsulePicker {

  private func isSelected(_ item: Item) -> Bool {
    selection == item

  }

  private func select(_ item: Item) {
    guard selection != item else { return }

    //    withAnimation(reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 0.75)) {
    selection = item
    //    }
  }

}
