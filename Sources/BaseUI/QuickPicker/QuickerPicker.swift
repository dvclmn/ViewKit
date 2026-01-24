//
//  QuickerPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import CoreTools
import SwiftUI

public struct QuickerPicker<SelectionValue: Hashable & Identifiable & NamedItem>: View {

  @State private var items: [SelectionValue]

  let title: LocalizedStringKey
  @Binding var selection: SelectionValue

  public var body: some View {

    Picker(title, selection: $selection) {
      ForEach(items) { item in
        Text(item.name).tag(item)
      }
    }

  }
}

extension QuickerPicker where SelectionValue: CaseIterable, SelectionValue.AllCases == [SelectionValue] {
  public init(
    _ title: LocalizedStringKey,
    selection: Binding<SelectionValue>
  ) {
    self.title = title
    self._selection = selection
    self._items = State(initialValue: SelectionValue.allCases)
  }
}

//extension ExampleView {
//
//}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  @Previewable @State var store = AppHandler()
//  ExampleView()
//    .environment(store)
//}
//#endif
