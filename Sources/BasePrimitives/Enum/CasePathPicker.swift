//
//  CasePathPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import SwiftUI

//public struct CasePickerFlow<Enum: MetaEnumProtocol & CasePathable, Content: View>: View
//where Enum.Meta: CaseIterable & Hashable & Identifiable {
//
//  private let title: String
//  @Binding private var selection: Enum
//  private let metaName: (Enum.Meta) -> String
//  private let content: (CaseControls<Enum>) -> Content
//
//  @StateObject private var cacheBox: CacheBox
//
//  // We need a reference-type wrapper so @StateObject can own it.
//  public final class CacheBox: ObservableObject {
//    @MainActor var cache: CasePayloadCache<Enum>
//    @MainActor init(_ initial: Enum) { self.cache = .init(initialValue: initial) }
//  }
//
//  public init(
//    _ title: String,
//    selection: Binding<Enum>,
//    metaName: @escaping (Enum.Meta) -> String,
//    @ViewBuilder content: @escaping (CaseControls<Enum>) -> Content
//  ) {
//    self.title = title
//    self._selection = selection
//    self.metaName = metaName
//    self.content = content
//    self._cacheBox = StateObject(wrappedValue: CacheBox(selection.wrappedValue))
//  }
//
//  public var body: some View {
//    VStack(alignment: .leading, spacing: 8) {
//
//      Picker(title, selection: metaBinding) {
//        ForEach(Array(Enum.Meta.allCases), id: \.id) { meta in
//          Text(metaName(meta)).tag(meta)
//        }
//      }
//
//      content(CaseControls(selection: $selection))
//    }
//  }
//
//  private var metaBinding: Binding<Enum.Meta> {
//    Binding(
//      get: { selection.meta },
//      set: { newMeta in
//        cacheBox.cache.select(newMeta, binding: $selection)
//      }
//    )
//  }
//}
//
//@MainActor
//public struct CaseControls<Enum: CasePathable> {
//  fileprivate let selection: Binding<Enum>
//
//  public var value: Enum { selection.wrappedValue }
//
//  /// Returns a payload binding if the enum is currently that case.
//  public func binding<Payload>(
//    _ casePath: AnyCasePath<Enum, Payload>
//  ) -> Binding<Payload>? {
//    guard casePath.extract(from: selection.wrappedValue) != nil else { return nil }
//
//    return Binding<Payload>(
//      get: {
//        /// Safe because we gated above and should only use while active.
//        guard let thing = casePath.extract(from: selection.wrappedValue) else {
//          fatalError("Shouldn't be possible, gated above")
//        }
//        return thing
//      },
//      set: { newPayload in
//        selection.wrappedValue = casePath.embed(newPayload)
//      }
//    )
//  }
//
//  /// Conditionally render controls for a case, with a real Binding to its payload.
//  @ViewBuilder
//  public func `case`<Payload, Content: View>(
//    _ casePath: AnyCasePath<Enum, Payload>,
//    @ViewBuilder content: (Binding<Payload>) -> Content
//  ) -> some View {
//    if let b = binding(casePath) {
//      content(b)
//    }
//  }
//}

/// ```
/// CasePicker(value: $lineShape, title: "Line Shapes") { meta in
///   Text(meta.name)
/// }
/// ```
///
/// Usage:
/// ```
/// CasePicker(
///   "Line Shape",
///   selection: $lineShape,
///   toMeta: \.meta,
///   fromMeta: \.parent,
///   metaName: \.name
/// )
/// ```
//public struct CasePicker<Root, Meta>: View
//where
//  Root: CasePathable & Identifiable,
//  Meta: Identifiable & CaseIterable & Hashable,
//  Root.ID == Meta.ID
//{
//  let title: String
//  @Binding var selection: Root
//  let toMeta: (Root) -> Meta
//  let fromMeta: (Meta) -> Root?
//  let metaName: (Meta) -> String
//
//  public init(
//    _ title: String,
//    selection: Binding<Root>,
//    toMeta: @escaping (Root) -> Meta,
//    fromMeta: @escaping (Meta) -> Root?,
//    metaName: @escaping (Meta) -> String
//  ) {
//    self.title = title
//    self._selection = selection
//    self.toMeta = toMeta
//    self.fromMeta = fromMeta
//    self.metaName = metaName
//  }
//
//  public var body: some View {
//    Picker(title, selection: caseBinding) {
//      ForEach(Array(Meta.allCases), id: \.id) { meta in
//        Text(metaName(meta)).tag(meta)
//      }
//    }
//  }
//}
//extension CasePicker {
//  private var caseBinding: Binding<Meta> {
//    Binding(
//      get: { toMeta(selection) },
//      set: { newMeta in
//        /// Early-exit if the IDs match (no change)
//        guard toMeta(selection).id != newMeta.id else { return }
//
//        /// Early-exit if cannot construct a new Root from Meta
//        guard let newValue = fromMeta(newMeta) else { return }
//
//        selection = newValue
//      }
//    )
//  }
//}
//extension CasePicker {
//  private var caseBinding: Binding<Meta> {
//    Binding(
//      get: { toMeta(selection) },
//      set: { newMeta in
//        if toMeta(selection).id != newMeta.id {
//          if let newValue = fromMeta(newMeta) {
//            selection = newValue
//          }
//        }
//      }
//    )
//  }
//}

//struct LineShapePickerDemo: View {
//  @Binding var lineShape: LineShape
//
//  var body: some View {
//    let selection = $lineShape.metaSelection(preservingPayloads: true)
//
//    VStack(alignment: .leading, spacing: 12) {
//      Picker("Line Shapes", selection: selection) {
//        ForEach(LineShape.Meta.allCases) { meta in
//          Text(meta.name).tag(meta)
//        }
//      }
//
//      // Conditional UI (based on case)
//      switch lineShape {
//        case .triangle:
//          Text("Triangle options…")
//
//        case .diamond:
//          Text("Diamond options…")
//
//        case .wave:
//          WaveOptions(lineShape: $lineShape)
//      }
//    }
//  }
//}
