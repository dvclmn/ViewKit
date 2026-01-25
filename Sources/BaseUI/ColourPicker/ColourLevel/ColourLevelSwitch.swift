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

public struct ColourLevelSwitch<Colour: ColourModel & EnvironmentResolvableColour>: View {
  @Environment(\.modifierKeys) private var modifierKeys
  @State private var isHovering: Bool = false

  @Binding var level: ColourLevel
  @Binding var foreground: Colour
  @Binding var background: Colour

  let diameter: CGFloat
  let overlapFactor: CGFloat

  let mode: SwitchMode

  public init(
    level: Binding<ColourLevel>,
    foreground: Binding<Colour>,
    background: Binding<Colour>,
    diameter: CGFloat,
    overlapFactor: CGFloat,
    mode: SwitchMode
  ) {
    self._level = level
    self._foreground = foreground
    self._background = background
    self.diameter = diameter
    self.overlapFactor = overlapFactor
    self.mode = mode
  }

  public var body: some View {

    ZStack {
      switch mode {
        case .switcher:
          Level(.foreground)
          Level(.background)

        case .single:
          switch level {
            case .foreground: Level(.foreground)
            case .background: Level(.background)
          }
      }
    }
    .allowsHitTesting(!modifierKeys.isHoldingOption)
    .frame(width: swatchPairTotalWidth)
    
    .onHover { isHovering = $0 }

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

  @ViewBuilder
  private func Level(_ colourLevel: ColourLevel) -> some View {
    Button {
      level = colourLevel
    } label: {
      ZStack {
        PatternCanvas(preset: .opacityCheckerboard)
        switch colourLevel {
          case .foreground: foreground.toColour
          case .background: background.toColour
        }
      }
      .frameFromSquare(diameter)
      .clipShape(.circle)
      .overlay {
        if isActiveAndSwitchMode(colourLevel) {
          Circle().fill(.clear).stroke(.white, lineWidth: 1)
        }
      }
      
      //      ColourLevelView(
      //        level: colourLevel,
      //        foreground: foreground,
      //        background: background,
      //        diameter: diameter,
      //        overlapFactor: overlapFactor
      //      )
      
      .offset(x: offsetAmount(colourLevel))
      .zIndex(isActiveAndSwitchMode(colourLevel) ? 2 : 1)
      .accessibilityLabel(Text("Edit \(colourLevel.name) Colour"))
      .animation(
        .snappy(duration: 0.22, extraBounce: 0.13),
        value: colourLevel
      )
      .id(colourLevel)
      
//      .contentShape(.rect)
      
    }
//    .border(Color.green.opacity(0.3))
    .buttonStyle(.plain)
  }

  var swatchPairTotalWidth: CGFloat {
    /// *Both* swatches are drawn in toward one another by
    /// `swatchOverlap`, hence why we only subtract half of it here
    (diameter * 2) - (overlapFactor * diameter / 2)
  }

  private func offsetAmount(_ colourLevel: ColourLevel) -> CGFloat {
    guard mode.isSwitcher else { return .zero }
   return isActive(colourLevel) ? -swatchOverlap : swatchOverlap
  }
  
  private var swatchOverlap: CGFloat {
    diameter * overlapFactor
  }

  private func isActiveAndSwitchMode(_ colourLevel: ColourLevel) -> Bool {
    colourLevel == level && mode.isSwitcher
  }
  
  private func isActive(_ colourLevel: ColourLevel) -> Bool {
    colourLevel == level
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
