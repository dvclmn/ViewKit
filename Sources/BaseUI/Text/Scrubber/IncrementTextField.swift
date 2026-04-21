//
//  IncrementTextField.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/1/2026.
//

import BasePrimitives
import SwiftUI
import InputPrimitives

struct IncrementTextField: View {
  @Environment(\.fractionLength) private var fractionLength
  @Environment(\.modifierKeys) private var modifierKeys
  @Environment(\.isDebugMode) private var isDebugMode

  @Bindable var store: ScrubberHandler
  var body: some View {

    TextField(
      store.title,
      value: $store.value,
      //      value: isDraggable ? .constant(nil) : $store.value,
      format: .number.precision(.fractionLength(fractionLength ?? 0)),
      prompt: isDraggable ? Text("") : nil,
    )
    .multilineTextAlignment(.trailing)
    .labelsHidden()
    .focusEffectDisabled(isDraggable)
    .allowsHitTesting(!isDraggable)

    .onKeyPress(keys: [.upArrow, .downArrow]) { press in
      store.handleKeyPress(
        key: press.key,
        modifiers: modifierKeys
      )
    }
  }
}

extension IncrementTextField {
  private var isDraggable: Bool {
    (isPreview && isDebugMode) || modifierKeys.isHoldingOption
  }
}
