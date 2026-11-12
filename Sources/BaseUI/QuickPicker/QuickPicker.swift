//
//  QuickPicker.swift
//  Components
//
//  Created by Dave Coleman on 18/1/2025.
//

import CoreTools
import ViewTools
import SwiftUI

public struct QuickPicker<Item: LabeledItem & Hashable>: View {

  @Environment(\.quickPickerStyle) private var style

  let title: String
  @Binding var selection: Item

  /// The items representing what the Picker chooses from
  let sourceData: [Item]

  /// `sourceData` is for when `Item` is not CaseIterable
  public init(
    _ title: String,
    selection: Binding<Item>,
    sourceData: [Item],
  ) {
    self.title = title
    self._selection = selection
    self.sourceData = sourceData
  }

  public var body: some View {
    switch style {
      case .plain:
        Picker(title, selection: $selection) {
          ForEach(sourceData) { item in
            QuickLabel(item.label)
              .tag(item)
              
          }
        }

      case .capsule:
        CapsulePicker(
          title: title,
          selection: $selection,
          sourceData: sourceData,
        )
      }
  }
}

extension QuickPicker where Item: CaseIterable {
  public init(
    _ title: String,
    selection: Binding<Item>,
  ) where Item.AllCases: RandomAccessCollection, Item.AllCases.Element == Item, Item.AllCases == [Item] {
    self.title = title
    self._selection = selection
    self.sourceData = Item.allCases
  }
}
