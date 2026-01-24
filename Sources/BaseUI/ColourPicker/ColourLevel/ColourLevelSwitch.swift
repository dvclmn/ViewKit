//
//  ColourLevelSwitch.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import CoreTools
import SwiftUI
import ColourKit

import SwiftUI

//@Observable
//final class ColourSwitchHandler {
//  let activeLevel: ColourLevel = .foreground
//}

public struct ColourLevelSwitch<Colour: ColourModel>: View {

  @Environment(\.modifierKeys) private var modifierKeys
  
//  @State private var store = ColourSwitchHandler()
  @State private var isHovering: Bool = false

  @Binding var level: ColourLevel
  @Binding var foreground: Colour
  @Binding var background: Colour
  
  let diameter: CGFloat
  let overlapFactor: CGFloat

  public init(
    level: Binding<ColourLevel>,
    foreground: Binding<Colour>,
    background: Binding<Colour>,
    diameter: CGFloat,
    overlapFactor: CGFloat
  ) {
    self._level = level
    self.diameter = diameter
    self.overlapFactor = overlapFactor
  }

  public var body: some View {

    ZStack {
      Button {
        level = .background
      } label: {
        ColourLevelView(level: .background)
      }

      ColourLevelView(level: .background)
      ColourLevelView(level: .foreground)
    }
    .allowsHitTesting(!modifierKeys.isHoldingOption)
    .frame(width: swatchPairTotalWidth)
    .onHover { isHovering = $0 }
    
    .overlay(alignment: .leading) {
      if isHovering && modifierKeys.isHoldingOption {
        Label("Swap Foreground and Background", systemImage: "arrow.uturn.right")
          .fontWeight(.medium)
          .foregroundStyle(
            .pink
            //            store.colourHandler.contrastingSwiftUIColour(for: .foreground, using: .contrastPreset(.highContrast), includesAlpha: false)
            //            store.colourHandler.selectedColour.contrastingBorderColour(using: .highContrast).nativeColour(includesAlpha: false)
          )
          .frame(width: diameter)
          .allowsHitTesting(false)
      }
    }
//    .gesture(tapSwapGesture, isEnabled: isHoldingOption)
    .padding(.horizontal, Styles.sizeRegular.bump)

  }
}
extension ColourLevelSwitch {

  var swatchPairTotalWidth: CGFloat {
    /// *Both* swatches are drawn in toward one another by
    /// `swatchOverlap`, hence why we only subtract half of it here
    (diameter * 2) - (overlapFactor * diameter / 2)
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
