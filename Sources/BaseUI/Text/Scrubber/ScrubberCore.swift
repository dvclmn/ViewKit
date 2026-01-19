//
//  ScrubberCore.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import SwiftUI
import CoreTools

struct ScrubberCore: View {
  @Environment(\.fractionLength) private var fractionLength
  @Environment(\.scrubberComponents) private var components
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.modifierKeys) private var modifierKeys
  
  @Bindable var store: ScrubberHandler
  var body: some View {
    HStack(spacing: layoutSpacing) {
      // MARK: - Text Editor
      /// This is both providing layout (TextField is overlaid),
      /// and also a draggable, non-editable view of the value
      Text(store.valueString(places: fractionLength))
      //    Text(valueClamped.wrappedValue.displayString(places: fractionLength ?? 0))
        .allowsHitTesting(modifierKeys.isHoldingOption)
        .opacity(modifierKeys.isHoldingOption ? 1 : 0)
        .setPointerStyle(.frameResize(position: .leading, directions: .all))
        .padding(.horizontal, Styles.sizeSmall)
        .environment(\.strokeColour, AnyShapeStyle(Color.white.opacity(store.isHovered ? 0.11 : 0)))
//        .backgroundTint(isDragging ? Color.accentColor.opacity(0.1) : nil)
//        .animation(Styles.animationQuickNSmooth, value: isDragging)
      
        .onHover { store.isHovered = $0 }
        .gesture(digitDragGesture(for: layoutAxis ?? .horizontal))
        .sensoryFeedback(.alignment, trigger: store.value) {
          oldValue,
          newValue in
          /// If no step provided, no haptics will occur.
          /// Only allow haptic feedback when actively dragging
          guard store.is else { return false }
          return HapticPreset.perStep(stepSize).shouldFire(oldValue, newValue)
        }
        .onDoubleTap { onDoubleTap() }
        .overlay {
          if !modifierKeys.isHoldingOption {
            IncrementTextField(
              store: store,
              title: store.title,
              //            value: valueClamped
            )
          }
        }
        .monospacedDigit()
      
      if components.contains(.stepper) {
        StepperView()
      }
    }
    
  }
}

extension ScrubberCore {
  
  
  /// Note: Native Stepper does not support varied increments
  /// based on modifier keys, will need to do this manually.
  @ViewBuilder
  private func StepperView() -> some View {
    Group {
      if let range = store.range {
        Stepper(
          store.title,
          value: $store.value,
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
