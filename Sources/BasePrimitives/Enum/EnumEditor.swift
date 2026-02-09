//
//  EnumEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import SwiftUI
import CasePaths

struct EnumEditor<E: MetaEnumProtocol>: View {
  @Binding var value: E
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Picker("Cases", selection: $value.metaSelection(preservingPayloads: true)) {
        ForEach(E.Meta.allCases) { meta in
          Text(String(describing: meta)).tag(meta)
        }
      }
      
      // Per-case controls
//      switch value {
//        case .speed:
//          if let speedBinding = binding(for: \E.speed) { // via CasePath
//            Stepper("Speed", value: speedBinding, in: 0...100)
//          }
//          
//        case .opacity:
//          if let opacityBinding = binding(for: \E.opacity) {
//            Slider(value: opacityBinding, in: 0...1)
//          }
//          
//        case .title:
//          if let titleBinding = binding(for: \E.title) {
//            TextField("Title", text: titleBinding)
//          }
//      }
    }
  }
  
  // Example helper that uses CasePath to build a binding to an associated value.
  // The exact implementation depends on how your CasePath helpers are structured.
  private func binding<T>(for casePath: CasePath<E, T>) -> Binding<T>? {
    guard let current = casePath.extract(from: value) else { return nil }
    return Binding<T>(
      get: { casePath.extract(from: value) ?? current },
      set: { new in value = casePath.embed(new) }
    )
  }
}
