//
//  ColourLevelView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourTools
import CoreTools
import ViewTools
import GraphicsKit
import SwiftUI

public struct ColourLevelView<Colour: ColourModel & EnvironmentResolvableColour & SwiftUIColourConvertible>: View {

  @Environment(\.modifierKeys) private var modifierKeys

  let level: ColourLevel
  let foreground: Colour
  let background: Colour
  let diameter: CGFloat
  let overlapFactor: CGFloat

  public var body: some View {

    ZStack {
      PatternCanvas(preset: .opacityCheckerboard)
      switch level {
        case .foreground: foreground.toColour
        case .background: background.toColour
      }
    }
    .squareFrame(diameter)
//    .frameFromSquare(diameter)
    .clipShape(.circle)
    .overlay {
      Circle().fill(.clear).stroke(.white, lineWidth: 1)
    }

    //    .onAppear {
    //      if isPreview {
    //        store.colourHandler.foregroundRGB.opacity(0.3)
    //      }
    //    }

    //      .border(Color.green.opacity(0.3))

  }
}
extension ColourLevelView {
  private func isActive(_ colour: Colour) -> Bool {
    switch level {
      case .foreground: colour == foreground 
      case .background: colour == background
    }
  }

  //  var tapGesture: some Gesture {
  //    TapGesture()
  //      .onEnded { _ in
  //
  //      }
  //  }
  //
  //  var isHoldingOption: Bool {
  //    return modifierKeys.contains(.option)
  //  }

  // MARK: - Main States
  //  var isHovered: Bool {
  //    return store.colourHandler.hoveredColourLevel == level && !isHoldingOption
  //  }
  //  var isFocused: Bool {
  //    store.colourHandler.focusedColourLevel == level
  //  }
  //  var isActive: Bool {
  //    store.colourHandler.activeColourLevel == level
  //  }

  //  var swatchSize: CGFloat {
  //    isHovered ? store.swatchDiameter + 2 : store.swatchDiameter
  //  }

  //  var isShowingSwappable: Bool {
  //    isHovered && modifierKeys.contains(.option)
  //  }

  //  var strokeWidth: CGFloat {
  //    switch (isActive, isFocused) {
  //      case (false, true): 2
  //      case (true, false): 1
  //      default: 0
  //    }
  //
  //    //    if isFocused {
  //    //
  //    //    } else {
  //    //
  //    //      return level.isSelected(store.colourHandler) ? 1 : 0
  //    //    }
  //  }

  // TODO: Turn this back on
  //  var swatchStrokeColour: Color {
  //    return store.colourHandler.contrastingSwiftUIColour(
  //      for: level,
  //      using: .contrastPreset(.subtle),
  //      includesAlpha: true
  //    )
  ////    return store.colourHandler.rgbSwiftUIColour(for: level).contrastingBorderColour(using: .subtle)
  //
  //    //    store.colourHandler.selectedColour.contrastingBorderColour().toColour
  //  }

  //  var swatchStrokeColour: Color {
  //    guard isFocused else {
  //      return store.colourHandler.selectedColour.contrastingBorderColour(using: .subtle)
  //        .nativeColour(includesAlpha: false)
  //    }
  //    return store.colourHandler.selectedColour.contrastingBorderColour(using: .highContrast)
  //      .nativeColour(includesAlpha: false)
  //    //    store.colourHandler.selectedColour.contrastingBorderColour().toColour
  //  }

  //  func zIndex(_ level: ColourLevel) -> Double {
  //    guard store.isColourLevelActive(level) else {
  //      return 1
  //    }
  //    return 2
  //  }

}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  Toolbar_ColourSwatch()
//}
//#endif
//
