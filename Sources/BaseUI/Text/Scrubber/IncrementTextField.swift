//
//  IncrementTextField.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/1/2026.
//

import SwiftUI

struct IncrementTextField: View {
  @Environment(\.fractionLength) private var fractionLength
  @Environment(\.modifierKeys) private var modifierKeys
  @Bindable var store: ScrubberHandler
  var body: some View {

    TextField(
      store.title,
      value: $store.value,
      format: .number.precision(.fractionLength(fractionLength ?? 0))
    )
    .labelsHidden()
    .onKeyPress(keys: [.upArrow, .downArrow]) { press in
      store.handleKeyPress(
        key: press.key,
        modifiers: modifierKeys
      )
    }
  }
}
