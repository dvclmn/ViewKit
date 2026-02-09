//
//  CasePathPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import SwiftUI

/// ```
/// CasePicker(value: $lineShape, title: "Line Shapes") { meta in
///   Text(meta.name)
/// }
/// ```

/// Usage:
/// ```
/// CasePathablePicker(
///   "Line Shape",
///   selection: $lineShape,
///   toMeta: \.meta,
///   fromMeta: \.parent,
///   metaName: \.name
/// )
/// ```
public struct CasePathablePicker<Root, Meta>: View
where
  Root: CasePathable & Identifiable,
  Meta: Identifiable & CaseIterable & Hashable,
  Root.ID == Meta.ID
{
  let title: String
  @Binding var selection: Root
  let toMeta: (Root) -> Meta
  let fromMeta: (Meta) -> Root?
  let metaName: (Meta) -> String

  public init(
    _ title: String,
    selection: Binding<Root>,
    toMeta: @escaping (Root) -> Meta,
    fromMeta: @escaping (Meta) -> Root?,
    metaName: @escaping (Meta) -> String
  ) {
    self.title = title
    self._selection = selection
    self.toMeta = toMeta
    self.fromMeta = fromMeta
    self.metaName = metaName
  }

  public var body: some View {
    Picker(title, selection: caseBinding) {
      ForEach(Array(Meta.allCases), id: \.id) { meta in
        Text(metaName(meta)).tag(meta)
      }
    }
  }
}
extension CasePathablePicker {
  private var caseBinding: Binding<Meta> {
    Binding(
      get: { toMeta(selection) },
      set: { newMeta in
        /// Early-exit if the IDs match (no change)
        guard toMeta(selection).id != newMeta.id else { return }
        
        /// Early-exit if cannot construct a new Root from Meta
        guard let newValue = fromMeta(newMeta) else { return }
        
        selection = newValue
      }
    )
  }
}
//extension CasePathablePicker {
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
