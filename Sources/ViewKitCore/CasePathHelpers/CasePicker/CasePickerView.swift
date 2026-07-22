//
//  CasePickerView.swift
//  ViewKit
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import EnumMacroSupport
import SwiftUI

/// A self-contained case picker and associated-value editor.
///
/// `CasePicker` places the case-selection control and its case-specific content
/// in the same view hierarchy. It is suited to compact editors where those
/// elements belong together. For a selection control whose content lives
/// elsewhere, such as a toolbar driving an inspector body, use
/// ``CaseMetaPicker`` with a caller-owned ``CasePathHandler``.
public struct CasePicker<Root, Meta, Content>: View
where
  Root: MetaEnumRepresentable & CasePathable,
  Meta == Root.Meta,
  Content: View
{
  let title: String
  @Binding var selection: Root
  @State private var state: CasePathHandler<Root>
  @ViewBuilder let content: (CaseProxy<Root>) -> Content
  let clampAny: Any?

  public init(
    _ title: String,
    selection: Binding<Root>,
    clamp: Any? = nil,
    @ViewBuilder content: @escaping (CaseProxy<Root>) -> Content
  ) {
    self.title = title
    self._selection = selection
    self._state = State(initialValue: CasePathHandler(initialValue: selection.wrappedValue))
    self.content = content
    self.clampAny = clamp
  }

  public var body: some View {
    CaseMetaPicker(
      title,
      selection: $selection,
      handler: state,
    )
    content(CaseProxy(selection: $selection))
  }
}
