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
///
/// The convenience initialiser labels cases with their generated names. Use the
/// label-enabled initialiser when the picker needs richer case labels.
public struct CasePicker<Root, Meta, Label, Content>: View
where
  Root: MetaEnumRepresentable & CasePathable,
  Meta == Root.Meta,
  Label: View,
  Content: View
{
  let title: String
  @Binding var selection: Root
  @State private var state: CasePathHandler<Root>
  let content: (CaseProxy<Root>) -> Content
  let label: (Root.Meta) -> Label
  let clampAny: Any?

  /// Creates a self-contained case picker with custom labels for each case.
  ///
  /// - Parameters:
  ///   - title: The picker's accessibility label.
  ///   - selection: The complete associated-value enum being edited.
  ///   - label: A view describing each case-only meta value.
  ///   - content: The case-specific editor content.
  public init(
    _ title: String,
    selection: Binding<Root>,
    clamp: Any? = nil,
    @ViewBuilder content: @escaping (CaseProxy<Root>) -> Content,
    @ViewBuilder label: @escaping (Root.Meta) -> Label,
  ) {
    self.title = title
    self._selection = selection
    self._state = State(initialValue: CasePathHandler(initialValue: selection.wrappedValue))
    self.clampAny = clamp
    self.content = content
    self.label = label
  }

  public var body: some View {
    CaseMetaPicker(
      title,
      selection: $selection,
      handler: state,
      label: label,
    )
    content(CaseProxy(selection: $selection))
  }
}

extension CasePicker where Label == Text {
  /// Creates a self-contained case picker using each generated meta case's name.
  ///
  /// This preserves the concise initialiser and default labels used by earlier
  /// versions of `CasePicker`. Supply `label:` to the designated initialiser when
  /// the picker needs custom case labels.
  public init(
    _ title: String,
    selection: Binding<Root>,
    clamp: Any? = nil,
    @ViewBuilder content: @escaping (CaseProxy<Root>) -> Content,
  ) {
    self.init(
      title,
      selection: selection,
      clamp: clamp,
      content: content,
      label: { Text($0.name) },
    )
  }
}
