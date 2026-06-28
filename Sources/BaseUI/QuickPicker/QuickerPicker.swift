//
//  QuickerPicker.swift
//  ViewKit
//
//  Created by Dave Coleman on 24/1/2026.
import CoreTools
import ViewTools
import SwiftUI

public struct QuickerPicker<SelectionValue: Hashable & Identifiable & NamedItem>: View {
//public struct QuickerPicker<SelectionValue: Hashable & Identifiable & NamedItem, AdditionalContent: View>:
//  View
//{
//  public typealias QuickerUpdate = (SelectionValue) -> AdditionalContent

  @State private var items: [SelectionValue]

  let title: String
//  let title: LocalizedStringKey
  @Binding var selection: SelectionValue
  
  /// This is simply for when I don't want to use the default
  /// Text value, and want to handle my own View for each item.
//  let additionalContent: AdditionalContent?
//  let additionalContent: QuickerUpdate?

  //  public init(
  //    _ title: LocalizedStringKey,
  //    selection: Binding<SelectionValue>,
  //    @ViewBuilder additionalContent: @escaping AdditionalContent = { EmptyView() }
  ////  ) {
  //      ) where AdditionalContent == EmptyView {
  //    self.title = title
  //    self._selection = selection
  //    self._items = State(initialValue: SelectionValue.allCases)
  //    self.additionalContent = additionalContent
  //  }

  public var body: some View {

    Picker(title, selection: $selection) {
      ForEach(items) { item in
//        if let additionalContent {
//          additionalContent(item).tag(item)
//        } else {
          Text(item.name).tag(item)
//        }
      }
    }

  }
}

extension QuickerPicker where SelectionValue: CaseIterable, SelectionValue.AllCases == [SelectionValue] {

//  public init(
//    _ title: LocalizedStringKey,
//    selection: Binding<SelectionValue>,
//    @ViewBuilder additionalContent: @escaping QuickerUpdate
//  ) {
//    //  ) where AdditionalContent == EmptyView {
//    self.title = title
//    self._selection = selection
//    self._items = State(initialValue: SelectionValue.allCases)
//    self.additionalContent = additionalContent
//  }

  public init(
    _ title: String,
//    _ title: LocalizedStringKey,
    selection: Binding<SelectionValue>,
    //    @ViewBuilder additionalContent: @escaping () -> AdditionalContent = { EmptyView() }
      ) {
//  ) where AdditionalContent == EmptyView {
    self.title = title
    self._selection = selection
    self._items = State(initialValue: SelectionValue.allCases)
//    self.additionalContent = nil
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
