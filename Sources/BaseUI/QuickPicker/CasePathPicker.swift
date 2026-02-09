//
//  CasePathPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import CoreTools
import SwiftUI

/// Usage:
/// ```
/// CasePathablePicker(
///   selection: $lineShape,
///   toMeta: \.meta,
///   fromMeta: LineShape.init(fromMeta:),
///   label: "Line Shape",
///   metaName: \.name
/// )
/// ```

public struct CasePathablePicker<Root, Meta>: View
where
  Root: CasePathable & Identifiable,
  Meta: Identifiable & CaseIterable & Hashable,
  Root.ID == Meta.ID
{
  @Binding var selection: Root
  let toMeta: (Root) -> Meta
  let fromMeta: (Meta) -> Root?
  let label: String
  let metaName: (Meta) -> String

  public init(
    selection: Binding<Root>,
    toMeta: @escaping (Root) -> Meta,
    fromMeta: @escaping (Meta) -> Root?,
    label: String,
    metaName: @escaping (Meta) -> String
  ) {
    self._selection = selection
    self.toMeta = toMeta
    self.fromMeta = fromMeta
    self.label = label
    self.metaName = metaName
  }

  public var body: some View {
    Picker(
      label,
      selection: Binding(
        get: { toMeta(selection) },
        set: { newMeta in
          if toMeta(selection).id != newMeta.id {
            if let newValue = fromMeta(newMeta) {
              selection = newValue
            }
          }
        }
      )
    ) {
      ForEach(Array(Meta.allCases), id: \.id) { meta in
        Text(metaName(meta)).tag(meta)
      }
    }
  }
}

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

