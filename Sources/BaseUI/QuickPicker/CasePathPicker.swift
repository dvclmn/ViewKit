//
//  CasePathPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import SwiftUI
import CoreTools

/// Usage:
/// ```
/// CasePicker(value: $lineShape, title: "Line Shapes") { meta in
///   Text(meta.name)
/// }
/// ```
struct CasePicker<Value: MetaEnumProtocol, Label: View>: View {
  @Binding var value: Value
  var title: String
  var preservesPayloads: Bool = true
  @ViewBuilder var labelForMeta: (Value.Meta) -> Label
  
  var body: some View {
    Picker(title, selection: $value.metaSelection(preservingPayloads: preservesPayloads)) {
      ForEach(Value.Meta.allCases) { meta in
        labelForMeta(meta).tag(meta)
      }
    }
  }
}

struct CasePathablePicker<Root: CasePathable & Identifiable, Meta: Identifiable & CaseIterable>: View
where Root.ID == Meta.ID {
  @Binding var selection: Root
  let toMeta: (Root) -> Meta
  let fromMeta: (Meta) -> Root?
  let label: String
  let metaName: (Meta) -> String
  
  var body: some View {
    Picker(label, selection: Binding(
      get: { toMeta(selection) },
      set: { newMeta in
        if toMeta(selection).id != newMeta.id {
          if let newValue = fromMeta(newMeta) {
            selection = newValue
          }
        }
      }
    )) {
      ForEach(Array(Meta.allCases), id: \.id) { meta in
        Text(metaName(meta)).tag(meta)
      }
    }
  }
}

// Usage:
CasePathablePicker(
  selection: $lineShape,
  toMeta: \.meta,
  fromMeta: LineShape.init(fromMeta:),
  label: "Line Shape",
  metaName: \.name
)


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
