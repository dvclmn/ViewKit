//
//  CaseMetaPicker.swift
//  ViewKit
//
//  Created by Dave Coleman on 22/7/2026.
//

import EnumMacroSupport
import SwiftUI
import ViewTools
import CoreTools

/// A picker that switches an associated-value enum by case identity.
///
/// `CaseMetaPicker` renders only the selection control. Its
/// ``CasePathHandler`` is supplied by the caller so the handler can outlive the
/// picker and be shared by other selection surfaces, such as a toolbar, sidebar,
/// menu, or command group. The selected enum's associated values remain in the
/// caller's binding and the handler restores the last value used for each case.
///
/// Use ``CasePicker`` instead when the picker and case-specific editor belong in
/// one self-contained layout.
public struct CaseMetaPicker<Root, PickerLabel, CaseLabel>: View
where
  Root: MetaEnumRepresentable,
  PickerLabel: View,
  CaseLabel: View
{
  @Binding private var selection: Root
  private let handler: CasePathHandler<Root>
  private let pickerLabel: PickerLabel
  private let caseLabel: (Root.Meta) -> CaseLabel

  /// Creates a case-only picker with custom picker and case labels.
  ///
  /// Keep `handler` at the nearest stable owner shared by every control that can
  /// change `selection`. A handler stores inactive payloads in memory, so a new
  /// handler starts a new selection history.
  ///
  /// - Parameters:
  ///   - selection: The complete associated-value enum being edited.
  ///   - handler: The shared case-switching policy and in-memory payload cache.
  ///   - caseLabel: A view describing each case-only meta value.
  ///   - label: A view describing the picker itself.
  public init(
    selection: Binding<Root>,
    handler: CasePathHandler<Root>,
    @ViewBuilder caseLabel: @escaping (Root.Meta) -> CaseLabel,
    @ViewBuilder label: () -> PickerLabel,
  ) {
    self._selection = selection
    self.handler = handler
    self.caseLabel = caseLabel
    self.pickerLabel = label()
  }

  public var body: some View {
    Picker(selection: handler.metaBinding($selection)) {
      ForEach(Array(Root.Meta.allCases), id: \.self) { meta in
        caseLabel(meta)
          .tag(meta)
      }
    } label: {
      pickerLabel
    }
  }
}

extension CaseMetaPicker where PickerLabel == Text {
  /// Creates a case-only picker with a string title and custom case labels.
  public init(
    _ title: String,
    selection: Binding<Root>,
    handler: CasePathHandler<Root>,
    @ViewBuilder caseLabel: @escaping (Root.Meta) -> CaseLabel,
  ) {
    self.init(
      selection: selection,
      handler: handler,
      caseLabel: caseLabel,
      label: { Text(title) },
    )
  }
}

extension CaseMetaPicker where Root.Meta: LabeledItem, CaseLabel == QuickLabel {
  /// Creates a case-only picker with a custom picker label.
  public init(
    selection: Binding<Root>,
    handler: CasePathHandler<Root>,
    @ViewBuilder label: () -> PickerLabel,
  ) {
    self.init(
      selection: selection,
      handler: handler,
      caseLabel: { QuickLabel($0.label) },
      label: label,
    )
  }
}

extension CaseMetaPicker
where
  Root.Meta: LabeledItem,
  PickerLabel == Text,
  CaseLabel == QuickLabel
{
  /// Creates a case-only picker with a string title.
  public init(
    _ title: String,
    selection: Binding<Root>,
    handler: CasePathHandler<Root>,
  ) {
    self.init(
      selection: selection,
      handler: handler,
      caseLabel: { QuickLabel($0.label) },
      label: { Text(title) },
    )
  }
}
