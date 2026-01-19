//
//  IncrementTextField.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/1/2026.
//

import SwiftUI

struct IncrementTextField: View {
  @Environment(\.fractionLength) private var fractionLength
  @Bindable var store: ScrubberHandler
  let title: String
//  @Binding var value: Double
  var body: some View {

    TextField(
      title,
      value: $store.value,
      format: .number.precision(.fractionLength(fractionLength ?? 0))
    )
    .labelsHidden()
//    .onKeyPress(
//      keys: [.upArrow, .downArrow],
//      phases: .all
//    ) { press in
//      if press.key == .upArrow {
//        return updateValue(.up)
//
//      } else if press.key == .downArrow {
//        return updateValue(.down)
//
//      } else {
//        return .ignored
//      }
//    }
  }
}
