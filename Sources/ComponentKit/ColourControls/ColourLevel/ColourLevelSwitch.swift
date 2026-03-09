//
//  ColourLevelSwitch.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import BasePrimitives
import SwiftUI

public struct ColourLevelSwitch<Colour: ColourModel & HSVAdjustable & EnvironmentResolvableColour>: View {
  @Environment(\.activeColour) private var activeHierarchicalColour
  @Environment(\.modifierKeys) private var modifierKeys

  @State private var isHovering: Bool = false

  @Binding var primary: Colour
  @Binding var secondary: Colour?

  let diameter: CGFloat
  let overlapFactor: CGFloat

  public init(
    primary: Binding<Colour>,
    secondary: Binding<Colour?>,
    diameter: CGFloat,
    overlapFactor: CGFloat,
  ) {
    self._primary = primary
    self._secondary = secondary
    self.diameter = diameter
    self.overlapFactor = overlapFactor
  }

  public var body: some View {

    if let secondary {

      HStack {
        Level(.primary, colour: primary)
        Level(.secondary, colour: secondary)
      }
      .frame(width: swatchPairTotalWidth)
      .onHover { isHovering = $0 }

    } else {

      /// If there's only one colour provided, we don't even need
      /// to think about active colour level
      Level(.primary, colour: primary)
    }

  }
}

// MARK: - Swap State
extension ColourLevelSwitch {

  private var isDualColourMode: Bool { secondary != nil }

  //  private var contrastColour: Colour {
  //    let hsvAdjustment = HSVAdjustment(h: 0.1, s: 0.1, v: 0.2)
  //    let adjusted = primary.adjust(by: hsvAdjustment)
  //    return adjusted
  //  }

  func swapColours() {
    guard let currentSecondary = secondary else { return }
    let temp = primary
    primary = currentSecondary
    secondary = temp
    /// If you track selection elsewhere, you likely want the active slot to be .primary after swap.
    activeHierarchicalColour.wrappedValue = .primary
  }

  private func isActive(_ slot: HierarchicalColour) -> Bool {
    slot == .primary  // Foreground is always left
  }

  private func isActiveAndSwitchMode(_ slot: HierarchicalColour) -> Bool {
    isActive(slot) && isDualColourMode
  }

  private func index(for slot: HierarchicalColour) -> Double {
    isActiveAndSwitchMode(slot) ? 2 : 1
  }

  //  var activeColourBinding: Binding<Colour> {
  //    switch activeHierarchicalColour.wrappedValue {
  //      case .primary:
  //        return $primary
  //      case .secondary:
  //        /// If secondary can be nil, you’ll need to decide what to do in that case.
  //        /// Option A: Provide a default or disable selection when nil.
  //        return Binding(
  //          get: { secondary ?? primary },  // fallback to primary for read
  //          set: { newValue in secondary = newValue }  // write to secondary
  //        )
  //    }
  //  }

}

// MARK: - Supporting Views
extension ColourLevelSwitch {
  @ViewBuilder
  private func Level(
    _ slot: HierarchicalColour,
    colour: Colour
  ) -> some View {
    Button {
      withAnimation(Styles.animationSpringQuickNSubtle) {
        //      withAnimation(.snappy(duration: 0.22, extraBounce: 0.13)) {
        switch slot {
          case .primary:
            /// Already foreground; either no-op or present editor for foreground
            /// activeHierarchicalColour.wrappedValue = .primary
            break
          case .secondary:
            swapColours()
            /// After swapping, the tapped colour is now in .primary (left), so it's "active".
            activeHierarchicalColour.wrappedValue = .primary
        }
      }

    } label: {
      ColourLevelLabel(slot, colour: colour)
        .squareFrame(diameter)
    }
    //    .buttonStyle(.noClickAnimation(isPlain: true))
  }

  @ViewBuilder
  private func ColourLevelLabel(
    _ slot: HierarchicalColour,
    colour: Colour
  ) -> some View {

    ZStack {
      Circle()
        .inset(by: 1)
        .fill(
          .checkerboard(
            primary: RGBColour.gray(1),
            secondary: RGBColour.gray(0.7),
            scale: 5.5
          )
        )
      //        .fill(colour.alpha < 0.9 ? .checkerboard(scale: 5.5) : .clear)
      Circle()
        .fill(colour.toColour)
      //        .stroke(
      //          contrastColour.toColour,
      //          lineWidth: isActiveAndSwitchMode(slot) ? 2 : 0
      //        )
    }

    .offset(x: offsetAmount(slot))
    .animation(
      .snappy(duration: 0.22, extraBounce: 0.13),
      value: slot
    )
    //    .zIndex(isActiveAndSwitchMode(colourLevel) ? 2 : 1)
    .zIndex(index(for: slot))
    .accessibilityLabel(Text("Edit \(slot.name) Colour"))
    .id(slot)

  }
}

// MARK: - Geometry/Layout
extension ColourLevelSwitch {

  var swatchPairTotalWidth: CGFloat {
    /// *Both* swatches are drawn in toward one another by
    /// `swatchOverlap`, hence why we only subtract half of it here
    (diameter * 2) - ((overlapFactor * 2) * diameter / 2)
  }

  private func offsetAmount(_ slot: HierarchicalColour) -> CGFloat {
    guard isDualColourMode else { return .zero }
    return slot == .primary ? swatchOverlap : -swatchOverlap
  }

  private var swatchOverlap: CGFloat {
    diameter * overlapFactor
  }

}

/// This is from above, here for now
//    .allowsHitTesting(!modifierKeys.isHoldingOption)
//
//    .overlay(alignment: .leading) {
//      if isHovering && modifierKeys.isHoldingOption {
//        Label("Swap Foreground and Background", systemImage: "arrow.uturn.right")
//          .fontWeight(.medium)
//          .foregroundStyle(
//            .pink
//            //            store.colourHandler.contrastingSwiftUIColour(for: .foreground, using: .contrastPreset(.highContrast), includesAlpha: false)
//            //            store.colourHandler.selectedColour.contrastingBorderColour(using: .highContrast).nativeColour(includesAlpha: false)
//          )
//          .frame(width: diameter)
//          .allowsHitTesting(false)
//      }
//    }
//    .gesture(tapSwapGesture, isEnabled: isHoldingOption)
//    .padding(.horizontal, Styles.sizeRegular.bump)
