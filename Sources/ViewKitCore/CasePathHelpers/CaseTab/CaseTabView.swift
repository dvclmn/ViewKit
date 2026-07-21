//
//  CaseTabView.swift
//  ViewKit
//
//  Created by Dave Coleman on 21/7/2026.
//

import CasePaths
import EnumMacroSupport
import SwiftUI

/// A tab container that selects between the cases of an enum while retaining
/// each case's associated value.
///
/// `TabView` selects a single, hashable value. For an enum with associated
/// values, that value should be its generated ``MetaEnumRepresentable/Meta``
/// case identity rather than the complete enum value. `CaseTabView` owns that
/// conversion through ``CasePathHandler``, restoring the last value used for a
/// case when a person returns to its tab.
public struct CaseTabView<Root, TabLabel, Content>: View
where
  Root: MetaEnumRepresentable & CasePathable,
  TabLabel: View,
  Content: View
{
  @Binding private var selection: Root
  @State private var state: CasePathHandler<Root>

  @ViewBuilder private let label: (Root.Meta) -> TabLabel
  @ViewBuilder private let content: (Root.Meta, CaseProxy<Root>) -> Content

  /// Creates a case-aware tab container with a custom label for each case.
  ///
  /// - Parameters:
  ///   - selection: The complete enum value to edit.
  ///   - label: A label for each case-only meta value.
  ///   - content: Content for each tab. The case proxy derives bindings to the
  ///     selected case's associated value.
  public init(
    selection: Binding<Root>,
    @ViewBuilder label: @escaping (Root.Meta) -> TabLabel,
    @ViewBuilder content: @escaping (Root.Meta, CaseProxy<Root>) -> Content,
  ) {
    self._selection = selection
    self._state = State(initialValue: CasePathHandler(initialValue: selection.wrappedValue))
    self.label = label
    self.content = content
  }

  public var body: some View {
    let metaSelection = state.metaBinding($selection)
    let proxy = CaseProxy(selection: $selection)
    let cases = Array(Root.Meta.allCases)

    if #available(macOS 15, iOS 18, *) {
      TabView(selection: metaSelection) {
        ForEach(cases, id: \.self) { meta in
          Tab(value: meta) {
            content(meta, proxy)
          } label: {
            label(meta)
          }
        }
      }
    } else {
      TabView(selection: metaSelection) {
        ForEach(cases, id: \.self) { meta in
          content(meta, proxy)
            .tag(meta)
            .tabItem {
              label(meta)
            }
        }
      }
    }
  }
}

extension CaseTabView where TabLabel == Text {
  /// Creates a case-aware tab container using each generated meta case's name.
  public init(
    selection: Binding<Root>,
    @ViewBuilder content: @escaping (Root.Meta, CaseProxy<Root>) -> Content,
  ) {
    self.init(
      selection: selection,
      label: { Text($0.name) },
      content: content,
    )
  }
}
