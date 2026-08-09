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
public struct CasePicker<Root, PickerLabel, CaseLabel, Content>: View
where
  Root: MetaEnumRepresentable & CasePathable,
  PickerLabel: View,
  CaseLabel: View,
  Content: View
{
  @Binding private var selection: Root
  @State private var state: CasePathHandler<Root>
  private let pickerLabel: PickerLabel
  private let caseLabel: (Root.Meta) -> CaseLabel
  private let content: (CaseProxy<Root>) -> Content
  private let clampAny: Any?

  /// Creates a self-contained case picker with custom picker and case labels.
  ///
  /// - Parameters:
  ///   - selection: The complete associated-value enum being edited.
  ///   - clamp: A value made available to case-specific editing infrastructure.
  ///   - content: The case-specific editor content.
  ///   - caseLabel: A view describing each case-only meta value.
  ///   - label: A view describing the picker itself.
  public init(
    selection: Binding<Root>,
    clamp: Any? = nil,
    @ViewBuilder content: @escaping (CaseProxy<Root>) -> Content,
    @ViewBuilder caseLabel: @escaping (Root.Meta) -> CaseLabel,
    @ViewBuilder label: () -> PickerLabel,
  ) {
    self._selection = selection
    self._state = State(initialValue: CasePathHandler(initialValue: selection.wrappedValue))
    self.pickerLabel = label()
    self.caseLabel = caseLabel
    self.content = content
    self.clampAny = clamp
  }

  public var body: some View {
    CaseMetaPicker(
      selection: $selection,
      handler: state,
      caseLabel: caseLabel,
      label: { pickerLabel },
    )
    content(CaseProxy(selection: $selection))
  }
}

// MARK: - Additional initialisers
extension CasePicker where PickerLabel == Text {
  /// Creates a self-contained case picker with a string title and custom case labels.
  public init(
    _ title: String,
    selection: Binding<Root>,
    clamp: Any? = nil,
    @ViewBuilder content: @escaping (CaseProxy<Root>) -> Content,
    @ViewBuilder caseLabel: @escaping (Root.Meta) -> CaseLabel,
  ) {
    self.init(
      selection: selection,
      clamp: clamp,
      content: content,
      caseLabel: caseLabel,
      label: { Text(title) },
    )
  }
}

extension CasePicker where CaseLabel == Text {
  /// Creates a self-contained case picker with a custom picker label.
  ///
  /// Each case is represented by its generated meta case name.
  public init(
    selection: Binding<Root>,
    clamp: Any? = nil,
    @ViewBuilder content: @escaping (CaseProxy<Root>) -> Content,
    @ViewBuilder label: () -> PickerLabel,
  ) {
    self.init(
      selection: selection,
      clamp: clamp,
      content: content,
      caseLabel: { Text($0.name) },
      label: label,
    )
  }
}

extension CasePicker where PickerLabel == Text, CaseLabel == Text {
  /// Creates a self-contained case picker with a string title.
  ///
  /// Each case is represented by its generated meta case name.
  public init(
    _ title: String,
    selection: Binding<Root>,
    clamp: Any? = nil,
    @ViewBuilder content: @escaping (CaseProxy<Root>) -> Content,
  ) {
    self.init(
      selection: selection,
      clamp: clamp,
      content: content,
      caseLabel: { Text($0.name) },
      label: { Text(title) },
    )
  }
}
