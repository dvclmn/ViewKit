//
//  FlexiLayoutView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 5/9/2025.
//


import SharedHelpers
import LayoutKit
import SwiftUI

public enum Flexi<Content, Item>
where Item: Sendable & Identifiable & Equatable, Item.ID: Hashable & Sendable, Content: View {}

extension Flexi {

  public typealias SingleSelect = Item.ID?
  public typealias MultiSelect = Set<Item.ID>

  public struct LayoutView: View {

    @State private var store: FlexiHandler<Item>

    /// These three Bindings are mirrored to
    /// `Flexi.Handler` using `.bind(_:to:)`
    @Binding var singleSelection: Flexi.SingleSelect
    @Binding var multiSelection: Flexi.MultiSelect
    @Binding var scrolledID: Item.ID?

    let data: [Item]
    let layoutMode: LayoutMode
    let groupPath: KeyPath<Item, String>?

    /// I want to pass layout mode here to try and better enforce
    /// the caller to make sure the mode matches this Flexi view
    let content: (Item) -> Content

    public var body: some View {

      if !data.isEmpty {
        Group {
          #if canImport(AppKit)
          LayoutView()

          #else
          Flexi.ListView(data: data, content: content)
            .environment(store)

          #endif
        }
        .bind($store.scrolledID, to: $scrolledID)
        .bind($store.singleSelection, to: $singleSelection)
        .bind($store.multiSelection, to: $multiSelection)

        .task(id: groupPath) {
          updateIfChanged(&store.groupPath, to: groupPath)
        }

        /// Curious to see if this is helpful; placing a strong guard here
        /// against using the wrong selection binding with the
        /// wrong selection mode.
        .task(id: store.selectionMode) {
          selectionModeCheck()
        }

        /// `layoutMode` is actually not used by either child view here;
        /// `GridView` or `ListView`. Still passing in case it's helpful
        /// to nested Views in the caller's domain.
        .environment(\.layoutMode, layoutMode)
        .environment(\.selectionMode, store.selectionMode)
        .environment(store)
      } else {
        StateView("No items to show", message: "Need to improve this Flexi empty state")
      }
    }
  }
}

extension Flexi.LayoutView {

  // MARK: - Main layout view
  @ViewBuilder
  private func LayoutView() -> some View {
    @Bindable var store = store
    switch layoutMode {
      case .grid:
        Flexi.GridView(data: data, content: content)

      case .list:
        Flexi.ListView(data: data, content: content)
    }

  }

  private func selectionModeCheck() {
    switch store.selectionMode {
      case .single:
        assert(
          store.multiSelection.isEmpty, "`multiSelection: Set<Item.ID>` cannot be used in single selection mode.")

      case .multi:
        assert(store.singleSelection == nil, "`singleSelection: Item.ID?` cannot be used in multi selection mode.")

    }
  }
}

// MARK: - Initialisers
extension Flexi.LayoutView {

  /// Note: The `@Binding` selection properties need to be
  /// here to communicate back to the caller
  // MARK: - Single select
  public init(
    layoutMode: LayoutMode,
    data: [Item],
    singleSelection: Binding<Flexi.SingleSelect>,
    //    singleSelection: Binding<Item.ID?>,
    scrolledID: Binding<Item.ID?>? = nil,
    groupedBy groupPath: KeyPath<Item, String>? = nil,
    @ViewBuilder content: @escaping (Item) -> Content
  ) {

    self._store = State(initialValue: FlexiHandler<Item>(mode: .single))
    //    let select = Flexi.Selection(
    //      selectionMode: .single,
    //      singleSelection: singleSelection().wrappedValue,
    //    )
    //    self._selection = Shared(wrappedValue: select, Flexi.SharedKeys.selection)
    self._singleSelection = singleSelection
    self._multiSelection = .constant([])
    self._scrolledID = scrolledID ?? .constant(nil)
    self.data = data
    self.groupPath = groupPath
    self.layoutMode = layoutMode
    self.content = content
  }

  // MARK: - Multi select
  public init(
    layoutMode: LayoutMode,
    data: [Item],
    multiSelection: Binding<Flexi.MultiSelect>,
    scrolledID: Binding<Item.ID?>? = nil,
    groupedBy groupPath: KeyPath<Item, String>? = nil,
    @ViewBuilder content: @escaping (Item) -> Content
  ) {

    self._store = State(initialValue: FlexiHandler<Item>(mode: .multi))
    //    let select = Flexi.Selection(
    //      selectionMode: .multi,
    //      multiSelection: multiSelection().wrappedValue,
    //    )
    //    self._selection = Shared(wrappedValue: select, Flexi.SharedKeys.selection)

    self._singleSelection = .constant(nil)
    self._multiSelection = multiSelection
    self._scrolledID = scrolledID ?? .constant(nil)
    self.data = data
    self.groupPath = groupPath
    self.layoutMode = layoutMode
    self.content = content
  }

}
