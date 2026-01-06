//
//  OpacitySlider.swift
//  BaseComponents
//
//  Created by Dave Coleman on 16/6/2025.
//

import ColourKit
import GraphicsKit
import SharedHelpers
import SwiftUI

@available(macOS 14.0, *)
extension Image {
  @MainActor
  static func checkerboard(scale: CGFloat = 10) -> Image {
    let renderer = ImageRenderer(
      content:
        Canvas {
          context,
          size in
          context.drawPattern(
            .checkerboard,
            config: PatternConfiguration(
              size: scale,
              gap: scale,
//              primaryColour: Color(white: 0.8),
//              secondaryColour: Color(white: 0.4)
              primaryColour: CodableColour.gray,
              secondaryColour: CodableColour.white
            ),
            in: size
          )
        }
        .frame(width: scale * 2, height: scale * 2)
    )
    renderer.scale = 2.0
    #if canImport(AppKit)
    guard let nsImage = renderer.nsImage else {
      return Image(systemName: "questionmark")
    }
    return Image(nsImage: nsImage)

    #else
    guard let uiImage = renderer.uiImage else {
      return Image(systemName: "questionmark")
    }
    return Image(uiImage: uiImage)

    #endif
  }

}

@MainActor
@available(macOS 14.0, *)
public struct OpacityShapeStyle: @preconcurrency ShapeStyle {

  let scale: CGFloat
  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    ImagePaint(
      image: Image.checkerboard(scale: scale),
      scale: 1.0
    )
  }
}

@available(macOS 14.0, *)
extension ShapeStyle where Self == OpacityShapeStyle {
  public static func checkerboard(scale: CGFloat = 10) -> Self {
    OpacityShapeStyle(scale: scale)
  }
}

@available(macOS 14.0, *)
extension AnyShapeStyle {
  public static func checkerboard(scale: CGFloat = 10) -> Self {
    AnyShapeStyle(OpacityShapeStyle(scale: scale))
  }
}

public struct OpacitySlider: View {
  @Environment(\.isEnabled) private var isEnabled

  @Binding var value: Double

  public init(value: Binding<Double>) {
    self._value = value
  }

  public var body: some View {

    Group {
      EmptyView()
      //      SimpleSlider(
      //        "Opacity",
      //        value: $value,
      //        range: 0...1
      //        //        formatValue: <#T##FormatSliderValue?#>,
      //        //        didChangeSlider: <#T##SliderOutput#>
      //      ) {
      //        PatternCanvas(preset: .opacityCheckerboard)
      //        LinearGradient(colors: [.clear, .white], startPoint: .leading, endPoint: .trailing)
      //      }

      //      SliderCustom($value, range: 0...1) {
      //        PatternCanvas(preset: .opacityCheckerboard)
      //        LinearGradient(colors: [.clear, .white], startPoint: .leading, endPoint: .trailing)
      //      }
    }
    .compositingGroup()
    .opacity(isEnabled ? 1.0 : 0.4)

    .overlay {
      ForEach(0..<9) { opacityInt in
        Button("Set opacity to \(opacityInt * 10)%") {
          value = opacityInt.toOpacity
          //          guard let activeLayerID = store.artworkHandler.activeLayerID else { return }
          //          artwork.wrappedValue.layers[id: activeLayerID]?.setOpacity(using: opacityLevel)
        }
        .keyboardShortcut(.init(Character(opacityInt.toString)), modifiers: [])
      }
      .hidden()
    }

  }
}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  OpacitySlider()
//}
//#endif
