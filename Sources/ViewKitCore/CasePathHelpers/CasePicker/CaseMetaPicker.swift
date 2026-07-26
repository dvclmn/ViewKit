//
//  CaseMetaPicker.swift
//  ViewKit
//
//  Created by Dave Coleman on 22/7/2026.
//

import EnumMacroSupport
import SwiftUI
import ViewTools

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
public struct CaseMetaPicker<Root, Label>: View
where Root: MetaEnumRepresentable, Label: View {
  private let title: String
  @Binding private var selection: Root
  private let handler: CasePathHandler<Root>
  private let label: (Root.Meta) -> Label

  /// Creates a case-only picker with a custom label for each meta case.
  ///
  /// Keep `handler` at the nearest stable owner shared by every control that can
  /// change `selection`. A handler stores inactive payloads in memory, so a new
  /// handler starts a new selection history.
  ///
  /// - Parameters:
  ///   - title: The picker's accessibility label.
  ///   - selection: The complete associated-value enum being edited.
  ///   - handler: The shared case-switching policy and in-memory payload cache.
  ///   - label: A view describing each case-only meta value.
  public init(
    _ title: String,
    selection: Binding<Root>,
    handler: CasePathHandler<Root>,
    @ViewBuilder label: @escaping (Root.Meta) -> Label,
  ) {
    self.title = title
    self._selection = selection
    self.handler = handler
    self.label = label
  }

  public var body: some View {
    Picker(title, selection: handler.metaBinding($selection)) {
      ForEach(Array(Root.Meta.allCases), id: \.self) { meta in
        label(meta)
          .tag(meta)
      }
    }
  }
}

extension CaseMetaPicker where Root.Meta: LabeledItem, Label == QuickLabel {
  /// Creates a case-only picker using each generated meta case's name.
  public init(
    _ title: String,
    selection: Binding<Root>,
    handler: CasePathHandler<Root>,
  ) {
    self.init(
      title,
      selection: selection,
      handler: handler,
      label: { QuickLabel($0.label) },
//      label: { Text($0.name) },
    )
  }
}
