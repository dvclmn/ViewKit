//
//  CasePickerView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import SwiftUI

public struct CasePicker<Root, Meta, Content>: View
where
  Root: MetaEnum & CasePathable,
  Meta == Root.Meta,
  Content: View
{
  let title: String
  @Binding var selection: Root
  @State private var state: CasePickerState<Root>
  @ViewBuilder let content: (CaseProxy<Root>) -> Content

  public init(
    _ title: String,
    selection: Binding<Root>,
    @ViewBuilder content: @escaping (CaseProxy<Root>) -> Content
  ) {
    self.title = title
    self._selection = selection
    self._state = State(initialValue: CasePickerState(initialValue: selection.wrappedValue))
    self.content = content
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      
      Picker(title, selection: metaBinding) {
        ForEach(Array(Meta.allCases), id: \.id) { meta in
          Text(meta.name).tag(meta)
        }
      }
      content(CaseProxy(selection: $selection))
    }
  }

}

extension CasePicker {
  private var metaBinding: Binding<Meta> {
    Binding(
      get: { selection.meta },
      set: { newMeta in state.switchTo(newMeta, binding: $selection) }
    )
  }
}
