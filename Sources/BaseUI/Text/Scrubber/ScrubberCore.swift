//
//  ScrubberCore.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import SwiftUI

struct ScrubberCore: View {
  var body: some View {
    
    // MARK: - Text Editor
    /// This is both providing layout (TextField is overlaid),
    /// and also a draggable, non-editable view of the value
    Text(store.valueString(places: fractionLength))
    //    Text(valueClamped.wrappedValue.displayString(places: fractionLength ?? 0))
      .allowsHitTesting(isHoldingOption)
      .opacity(isHoldingOption ? 1 : 0)
      .setPointerStyle(.frameResize(position: .leading, directions: .all))
      .padding(.horizontal, Styles.sizeSmall)
    
      .overlay {
        if !isHoldingOption {
          IncrementTextField(
            store: store,
            title: title,
            //            value: valueClamped
          )
        }
      }
      .monospacedDigit()
    
    if isStepperShowing {
      StepperView()
    }
    
  }
}

extension ScrubberCore {
  /// Note: Native Stepper does not support varied increments
  /// based on modifier keys, will need to do this manually.
  @ViewBuilder
  private func StepperView() -> some View {
    Group {
      if let range {
        Stepper(
          title,
          value: $value,
          in: range,
          step: store.stepSize(modifiers: modifierKeys)
        )
        
      } else {
        Stepper(
          title,
          value: $value,
          step: store.stepSize(modifiers: modifierKeys)
        )
      }
    }  // END group
       /// Don't need extra label, this Stepper is in a broader labeled View
    .labelsHidden()
    
  }
}
