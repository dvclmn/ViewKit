//
//  ColourLevelSwitch.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import CoreTools
import GraphicsKit
import SwiftUI

public struct ColourLevelSwitch<Colour: ColourModel & HSVAdjustable & EnvironmentResolvableColour>: View {
  @Environment(\.activeColour) private var activeHierarchicalColour
  @Environment(\.modifierKeys) private var modifierKeys

  @State private var isHovering: Bool = false

  /// Which slot is currently the foreground role
  @State private var foregroundSlot: HierarchicalColour = .primary

  //  @State private var activeColourID: Colour.ID?

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
    //    self._activeColourID = State(initialValue: primary.wrappedValue.id)
    self.diameter = diameter
    self.overlapFactor = overlapFactor
  }

  public var body: some View {

    if let secondary {

      HStack {
        //        switch activeColour.wrappedValue {
        //          case .foreground:
        Level(.primary, colour: primary)
        Level(.secondary, colour: secondary)

        //          case .background:
        //        }

        //          .zIndex(index(for: .background))
      }
      //      .task(id: activeColour.wrappedValue) {
      //      }
    } else {
      /// If there's only one colour provided, we don't even need
      /// to think about active colour level
      Level(.primary, colour: primary)
    }
    //    .allowsHitTesting(!modifierKeys.isHoldingOption)
    //      .frame(width: swatchPairTotalWidth)
    //
    //      .onHover { isHovering = $0 }

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

  }
}
extension ColourLevelSwitch {

  var backgroundSlot: HierarchicalColour {
    foregroundSlot == .primary ? .secondary : .primary
  }

  func swapForegroundAndBackground() {
    foregroundSlot = foregroundSlot == .primary ? .secondary : .primary
  }

  var activeColourBinding: Binding<Colour> {
    switch activeHierarchicalColour.wrappedValue {
      case .primary:
        return $primary
      case .secondary:
        // If secondary can be nil, you’ll need to decide what to do in that case.
        // Option A: Provide a default or disable selection when nil.
        return Binding(
          get: { secondary ?? primary },  // fallback to primary for read
          set: { newValue in secondary = newValue }  // write to secondary
        )
    }
  }

  var foregroundColourBinding: Binding<Colour> {
    switch foregroundSlot {
      case .primary: return $primary
      case .secondary:
        return Binding(
          get: { secondary ?? primary },
          set: { newValue in secondary = newValue }
        )
    }
  }

  var backgroundColourBinding: Binding<Colour> {
    switch backgroundSlot {
      case .primary: return $primary
      case .secondary:
        return Binding(
          get: { secondary ?? primary },
          set: { newValue in secondary = newValue }
        )
    }
  }

  func isColourActive(_ slot: HierarchicalColour) -> Bool {
    slot == activeHierarchicalColour.wrappedValue
  }

  func isForeground(_ slot: HierarchicalColour) -> Bool {
    slot == foregroundSlot
  }

  @ViewBuilder
  private func Level(
    _ colourLevel: HierarchicalColour,
    colour: Colour
  ) -> some View {
    Button {
      //      activeColour.wrappedValue = colourLevel
    } label: {
      ColourLevelLabel(colourLevel, colour: colour)
        .frameFromSquare(diameter)
    }
    //    .border(Color.green.opacity(0.3))
    .buttonStyle(.noClickAnimation(isPlain: true))
    .overlay {
      Text("")
    }
    //    .buttonStyle(.plain)
  }

  @ViewBuilder
  private func ColourLevelLabel(
    _ colourLevel: HierarchicalColour,
    colour: Colour
  ) -> some View {

    ZStack {
      Circle()
        .inset(by: 2)
        .fill(.checkerboard(scale: 5.5))
      Circle()
        .fill(colour.toColour)
        .strokeBorder(contrastColour.toColour, lineWidth: isActiveAndSwitchMode(colourLevel) ? 2 : 0)
    }

    .offset(x: offsetAmount(colourLevel))
    //    .zIndex(isActiveAndSwitchMode(colourLevel) ? 2 : 1)
    .accessibilityLabel(Text("Edit \(colourLevel.name) Colour"))
    .animation(
      .snappy(duration: 0.22, extraBounce: 0.13),
      value: colourLevel
    )
    .id(colourLevel)

    //      .contentShape(.rect)

  }

  private var isDualColourMode: Bool {
    secondary != nil
  }

  //  private func

//  private func index(for level: HierarchicalColour) -> Double {
//    guard isActiveAndSwitchMode(level) else {
//      return 1
//    }
//    return 2
//  }

  //  private func colourLevel(for hierarchy: HierarchicalColour) -> ColourLevel {
  //    switch activeColour.wrappedValue {
  //      case .foreground:
  //      case .background:
  //    }
  //  }

  var swatchPairTotalWidth: CGFloat {
    /// *Both* swatches are drawn in toward one another by
    /// `swatchOverlap`, hence why we only subtract half of it here
    (diameter * 2) - (overlapFactor * diameter / 2)
  }

  private func offsetAmount(_ colourLevel: HierarchicalColour) -> CGFloat {
    guard isDualColourMode else { return .zero }
    return isActive(colourLevel) ? -swatchOverlap : swatchOverlap
  }

  private var swatchOverlap: CGFloat {
    diameter * overlapFactor
  }

//  private func isActiveAndSwitchMode(_ colourLevel: HierarchicalColour) -> Bool {
//    colourLevel == activeHierarchicalColour.wrappedValue && isDualColourMode
//  }
//
//  private func isActive(_ colourLevel: HierarchicalColour) -> Bool {
//    colourLevel == activeHierarchicalColour.wrappedValue
//  }

  private var contrastColour: Colour {
    let hsvAdjustment = HSVAdjustment(h: 0.1, s: 0.0, v: 0.1)
    let adjusted = primary.adjust(by: hsvAdjustment)
    return adjusted
  }

  //  var tapSwapGesture: some Gesture {
  //    TapGesture()
  //      .onEnded { _ in
  //        store.colourHandler.swapColours()
  //      }
  //  }

  //  var isHoldingOption: Bool {
  //    return modifierKeys.contains(.option)
  //  }

  //  var isShowingSwappable: Bool {
  //    store.colourHandler.hoveredColourLevel != nil && isHoldingOption
  //  }
}

//extension ColourLevel {
//  func isActive()
//}
