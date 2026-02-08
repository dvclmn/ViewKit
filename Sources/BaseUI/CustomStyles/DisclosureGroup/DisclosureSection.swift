//
//  DisclosureSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import CoreTools
import SwiftUI

public struct DisclosureSection<Content: View>: View {

  /// External override (caller fully controls state)
  private var externalExpanded: Binding<Bool>?

  /// Internal ephemeral fallback
  @State private var transientExpanded: Bool

  /// Internal persisted slot (only used when enabled)
  @AppStorage private var persistedExpanded: Bool
  private let usesPersistence: Bool

  let title: String
  let content: Content

  /// 1) External binding initialiser (caller may persist or not)
  public init(
    _ title: String,
    isExpanded: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.content = content()
    self.externalExpanded = isExpanded

    /// These must be initialised, but they won't be used when externalExpanded is set.
    self._transientExpanded = State(initialValue: isExpanded.wrappedValue)
    self._persistedExpanded = AppStorage(wrappedValue: isExpanded.wrappedValue, "unused.disclosure.key")
    self.usesPersistence = false
  }

  /// 2) Optional persistence initialiser (auto-persist only if key provided)
  public init(
    _ title: String,
    defaultExpanded: Bool = true,
    persistenceKey: String? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.content = content()
    self.externalExpanded = nil

    self._transientExpanded = State(initialValue: defaultExpanded)

    if let persistenceKey {
      self._persistedExpanded = AppStorage(wrappedValue: defaultExpanded, persistenceKey)
      self.usesPersistence = true
    } else {

      /// Key won't be used because usesPersistence == false
      self._persistedExpanded = AppStorage(wrappedValue: defaultExpanded, "unused.disclosure.key")
      self.usesPersistence = false
    }
  }

  public var body: some View {

    Section {
      if expanded.wrappedValue {
        content
      } else {
        Label("Hidden", systemImage: "eye")
          .symbolVariant(.slash.fill)
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(.tertiary)
      }
    } header: {
      HStack {
        Text(title)
        Spacer()
        Toggle(isOn: expanded) {
          Text(expanded.wrappedValue ? "Hide" : "Show")
            .font(.caption.weight(.medium))
            .textCase(.uppercase)
        }
        .buttonStyle(.plain)
        .toggleStyle(.button)
        .controlSize(.small)
      }
    }

    //    Section {
    //      if isExpanded {
    //        content
    //      } else {
    //        Label("Hidden", systemImage: Icons.eye.icon)
    //          .symbolVariant(.slash.fill)
    //          .symbolRenderingMode(.hierarchical)
    //          .foregroundStyle(.tertiary)
    //      }
    //    } header: {
    //      HStack {
    //        Text(title)
    //        Spacer()
    //        ToggleButton()
    //      }
    //    }
  }
}

extension DisclosureSection {

  /// The single source of truth the view will use
  private var expanded: Binding<Bool> {
    if let externalExpanded { return externalExpanded }
    return usesPersistence ? $persistedExpanded : $transientExpanded
  }
}

//extension DisclosureSection {
//  @ViewBuilder
//  private func ToggleButton() -> some View {
//
//    Toggle(isOn: $isExpanded) {
//      Text(isExpanded ? "Hide" : "Show")
//        .foregroundColor(
//          isExpanded
//            ? .secondary.opacity(0.5)
//            : .secondary.opacity(0.8)
//        )
//        .font(.caption.weight(.medium))
//        .textCase(.uppercase)
//    }
//    .buttonStyle(.plain)
//    .toggleStyle(.button)
//    .controlSize(.small)
//  }
//}
