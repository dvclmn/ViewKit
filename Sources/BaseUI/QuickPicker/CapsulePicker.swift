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
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  let title: String
  @Binding var selection: Item
  let sourceData: [Item]

  @Namespace private var animation

  var body: some View {

    HStack(spacing: 0) {
      ForEach(Array(sourceData.enumerated()), id: \.element.id) { index, item in
        
        let isSelected = selection == item

        Button {
          select(item)
        } label: {
//          Text("Hello")
          QuickLabel(item.label)
            
//            .font(.callout.weight(isSelected ? .semibold : .regular))
//            .foregroundStyle(isSelected ? .background : .primary)
            .frame(maxWidth: .infinity)
            .frame(minHeight: minimumHeight)
            .contentShape(.rect)
            .background {
              if isSelected {
                Capsule()
//                  .fill(.tint)
                  .matchedGeometryEffect(id: "selectedItem", in: animation)
              }
            }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])

        if index < sourceData.count - 1 {
          Divider()
            .frame(height: 12)
            .opacity((selection == item || selection == sourceData[index + 1]) ? 0 : 0.5)
        }
      }
    }
    .padding(2)
    .background { Capsule().fill(.quaternary) }
    .accessibilityElement(children: .contain)
    .accessibilityLabel(title)
  }

  private var minimumHeight: CGFloat {
    28
    //    #if os(iOS)
    //    44
    //    #else
    //    28
    //    #endif
  }

  private func select(_ item: Item) {
    guard selection != item else { return }

    withAnimation(reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 0.75)) {
      selection = item
    }
  }
}
