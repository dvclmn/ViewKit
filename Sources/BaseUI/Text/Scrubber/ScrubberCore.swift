//
//  ScrubberCore.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CoreTools
import LayoutKit
import SwiftUI

struct ScrubberCore: View {
  @Environment(\.fractionLength) private var fractionLength
  @Environment(\.scrubberComponents) private var components
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.modifierKeys) private var modifierKeys
  @Environment(\.isDebugMode) private var isDebugMode

  @Bindable var store: ScrubberHandler
  var body: some View {
    HStack(spacing: isDraggable ? 4 : layoutSpacing) {
      // MARK: - Text Editor
      /// This is both providing layout (TextField is overlaid),
      /// and also a draggable, non-editable view of the value
      Text(store.valueString(places: fractionLength))
        /// This allows the drag behaviour to work correctly
        .textSelection(.disabled)
        .foregroundStyle(.primary)
        .opacity(isDraggable ? 1 : 0)

        .frame(minWidth: 30, alignment: .trailing)
        .padding(.horizontal, 4)
        .padding(.vertical, Styles.sizeTiny)
        .background {
          if isDraggable {
            RoundedRectangle(cornerRadius: 7)
              .fill(Color.black.tertiary.opacity(isDraggableAndHovered ? 1.0 : 0.6))
              .stroke(Color.white.opacity(isDraggableAndHovered ? 0.1 : 0.03), lineWidth: 1)
//              .offset(x: offsetThing)
//              .animation(Styles.animationSpringExtraBouncy, value: store.dragRangePhase)
          }
        }

        //        .environment(\.strokeColour, AnyShapeStyle(Color.white.opacity(store.isHovered ? 0.11 : 0)))
        /// Just for debug reference for now
        //        .foregroundStyle(.blue.secondary)

        //        .backgroundTint(isDragging ? Color.accentColor.opacity(0.1) : nil)
        //        .animation(Styles.animationQuickNSmooth, value: isDragging)
        //        .contentShape(.rect)
        .allowsHitTesting(isDraggable)

        .overlay {
          if !isDraggable {
            IncrementTextField(store: store)
          }
          //        .allowsHitTesting(isDraggable)
        }

        .pointerStyleCompatible(.frameResize(position: .leading, directions: .all))
        .onHover { store.isHovered = $0 }
        .gesture(ScrubDragGesture(store: store), isEnabled: isDraggable)
        .sensoryFeedback(.alignment, trigger: store.value) {
          oldValue,
          newValue in
          /// If no step provided, no haptics will occur.
          /// Only allow haptic feedback when actively dragging
          guard store.isDragging else { return false }
          let preset = store.strategy.scrubPreset(in: store.range, envOverride: nil)
          return preset.shouldFire(oldValue, newValue)
        }
        //        .onDoubleTap { onDoubleTap() }

        .monospacedDigit()

      if components.contains(.stepper) {
        StepperView()
          .disabled(isDraggable)
        //        if isDraggable {
        //          Image(systemName: "arrow.left.and.right")
        //            .font(.title2)
        //            .foregroundStyle(.tertiary)
        //        } else {
        //          StepperView()
        //
        //        }
      }
    }  // END hstack

  }
}

extension ScrubberCore {
  
  private var offsetThing: CGFloat {
    let base: CGFloat = switch store.dragRangePhase {
      case .idle:
          .zero
      case .nearBoundary(let boundary, let proximity):
        switch boundary {
          case .leading: -proximity
          case .trailing: proximity
        }
      case .overshooting(let boundary, let distance):
        switch boundary {
          case .leading: -distance
          case .trailing: distance
        }
    }
    
    return base * 10
  }
  
//  private var isPullingLeft: Bool {
//    /// This isn't a 'thing' with a range
//    guard let range = store.range else { return false }
//    let minCap = 2.0
//    let totalWidth = store.value - (minCap * 2)
//    guard range.contains((minCap * 2) + )
//    let buffer = max()
//    store.isDragging &&
//  }

  private var isDraggableAndHovered: Bool {
    isDraggable && store.isHovered
  }

  private var isDraggable: Bool {
    (isPreview && isDebugMode) || modifierKeys.isHoldingOption
  }

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
          store.title,
          value: $store.value,
          step: store.stepSize(modifiers: modifierKeys)
        )
      }
    }  // END group
    /// Don't need extra label, this Stepper is in a broader labeled View
    .labelsHidden()

  }
}
