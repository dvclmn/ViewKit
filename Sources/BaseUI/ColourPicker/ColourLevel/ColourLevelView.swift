//
//  ColourLevelView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import CoreTools
import GraphicsKit
import SwiftUI

public struct ColourLevelView: View {
  //  @Environment(AppHandler.self) private var store
  @Environment(\.modifierKeys) private var modifierKeys

  //  @Binding var level: ColourLevel
  let level: ColourLevel
  let diameter: CGFloat
  let overlapFactor: CGFloat

  public var body: some View {

    //    Button {
    //      store.colourHandler.focusedColourLevel = level
    //    } label: {

    ZStack {
      PatternCanvas(preset: .opacityCheckerboard)

      //        Rectangle()
      //          .fill(store.colourHandler.rgbSwiftUIColour(for: level))
    }
    .frame(width: store.swatchDiameter, height: store.swatchDiameter)
    .clipShape(.circle)
    .overlay {
      Circle()
        .fill(.clear)
        .stroke(.pink, lineWidth: 1)
    }
    //    }  // END button
    .buttonStyle(.plain)
    .offset(x: swatchOffset(level))
    .zIndex(zIndex(level))
    .accessibilityLabel(Text("Edit \(level.name) Colour"))
    .animation(.snappy(duration: 0.22, extraBounce: 0.13), value: store.colourHandler.activeColourLevel)
    .id(level)
    .onAppear {
      if isPreview {
        store.colourHandler.foregroundRGB.opacity(0.3)
      }
    }

    //      .border(Color.green.opacity(0.3))

  }
}
extension ColourLevelView {

  var tapGesture: some Gesture {
    TapGesture()
      .onEnded { _ in

      }
  }

  var isHoldingOption: Bool {
    return modifierKeys.contains(.option)
  }

  // MARK: - Main States
  //  var isHovered: Bool {
  //    return store.colourHandler.hoveredColourLevel == level && !isHoldingOption
  //  }
  var isFocused: Bool {
    store.colourHandler.focusedColourLevel == level
  }
  var isActive: Bool {
    store.colourHandler.activeColourLevel == level
  }

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

  #warning("Turn this back on")
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

  func zIndex(_ level: ColourLevel) -> Double {
    guard store.isColourLevelActive(level) else {
      return 1
    }
    return 2
  }

  func swatchOffset(_ level: ColourLevel) -> CGFloat {

    let offset = store.swatchOverlap
    guard store.isColourLevelActive(level) else {
      return offset
    }
    return -offset
  }
}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  Toolbar_ColourSwatch()
//}
//#endif
//
