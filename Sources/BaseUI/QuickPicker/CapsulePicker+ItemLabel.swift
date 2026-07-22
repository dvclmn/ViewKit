//
//  CapsulePicker+ItemLabel.swift
//  ViewKit
//
//  Created by Dave Coleman on 22/7/2026.
//

import SwiftUI
import ViewTools

struct CapsulePicker_ItemLabel: View {
  // @Environment(AppHandler.self) private var store
  let label: LabelDescriptor
  let isSelected: Bool
  var body: some View {

    //          Text("Hello")
    QuickLabel(label)

      //            .font(.callout.weight(isSelected ? .semibold : .regular))
      //            .foregroundStyle(isSelected ? .background : .primary)
      .frame(maxWidth: .infinity)
      .frame(minHeight: minimumHeight)
      .contentShape(.rect)
      .background {
        if isSelected {
          Capsule()
          //                  //                  .fill(.tint)
          //                  .matchedGeometryEffect(id: "selectedItem", in: animation)
        }
      }

  }
}

extension CapsulePicker_ItemLabel {
  private var minimumHeight: CGFloat { 28 }
}
