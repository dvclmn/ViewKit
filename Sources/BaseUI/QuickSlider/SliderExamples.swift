//
//  SliderExamples.swift
//  ViewKit
//
//  Created by Dave Coleman on 11/8/2025.
//

import ColourTools
import CoreTools
import SwiftUI
import ViewTools

public struct SliderExamples: View {
  @State private var nativeValue: Double = 2.0
  @State private var steppedValue: Double = 6.0
  @State private var gradientValue: Double = 0.42
  @State private var opacityValue: Double = 0.72
  @State private var compactValue: Double = 0.58
  @State private var colour = RGBColour(red: 0.32, green: 0.48, blue: 0.92, alpha: 0.68)
  @State private var activeColourModel: ColourModelKind = .rgb

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 18) {
        NativeSliders()
        #if os(macOS)
        Divider()
        AppKitTrackSliders()
        Divider()
        ComponentSliders()
        #endif
        Divider()
        ColourSlidersView()
      }
      .padding(24)
      .frame(maxWidth: 420, alignment: .leading)
    }
    .frame(minWidth: 360)
    .environment(\.layoutSpacing, 5)
    .environment(\.maxCharacterColumns, 4)
    .labelFontWeight(.semibold)
    .labelColour(for: .title, .secondary)
//    .labelColour(.secondary)
  }
}

extension SliderExamples {
  @ViewBuilder
  private func NativeSliders() -> some View {
    SliderGroup("Native") {
      QuickSlider(
        "Value",
        value: $nativeValue,
        range: 0.1...20,
      )
      .environment(\.sliderDefaultValue, 2.0)

      QuickSlider(
        "Stepped",
        value: $steppedValue,
        range: 0...10,
        step: 1,
      )
      .environment(\.sliderDefaultValue, 5.0)
    }
  }

  #if os(macOS)
  @ViewBuilder
  private func AppKitTrackSliders() -> some View {
    SliderGroup("AppKit tracks") {
      QuickSlider(
        "Gradient",
        value: $gradientValue,
        range: .unitRange,
        trackStyle: ExampleGradientTrackStyle(
          colours: [.purple, .blue, .cyan, .green]
        ),
      )
      .environment(\.sliderDefaultValue, 0.5)

      QuickSlider(
        "Opacity",
        value: $opacityValue,
        range: .unitRange,
        trackStyle: ExampleOpacityTrackStyle(colour: .indigo),
      )
      .environment(\.sliderDefaultValue, 1.0)

      QuickSlider(
        "Layered",
        value: $compactValue,
        range: .unitRange,
        trackStyle: ExampleLayeredTrackStyle(),
      )
      .environment(\.sliderDefaultValue, 0.5)
    }
  }

  @ViewBuilder
  private func ComponentSliders() -> some View {
    SliderGroup("Components") {
      QuickSlider(
        "Track",
        value: $compactValue,
        range: .unitRange,
        trackStyle: ExampleGradientTrackStyle(
          colours: [.orange, .pink, .purple]
        ),
      )
      .sliderComponents([.label, .track, .units])

      QuickSlider(
        "Thumb",
        value: $compactValue,
        range: .unitRange,
        trackStyle: ExampleGradientTrackStyle(
          colours: [.mint, .teal, .blue]
        ),
      )
      .sliderComponents([.label, .thumb, .units])

      QuickSlider(
        "No units",
        value: $compactValue,
        range: .unitRange,
        trackStyle: ExampleGradientTrackStyle(
          colours: [.red, .yellow, .green]
        ),
      )
      .sliderComponents(.noUnits)
    }
  }
  #endif

  @ViewBuilder
  private func ColourSlidersView() -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("Colour model", selection: $activeColourModel) {
        ForEach(ColourModelKind.allCases) { model in
          Text(model.name).tag(model)
        }
      }
      .pickerStyle(.segmented)
      .labelsHidden()

      HStack(spacing: 10) {
        RoundedRectangle(cornerRadius: 6, style: .continuous)
          .fill(colour.toColour)
          .frame(width: 32, height: 32)
          .overlay {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
              .stroke(.quaternary)
          }

        ColourSliders($colour)
          .environment(\.activeColourModel, $activeColourModel)
      }
    }
  }
}

#if os(macOS)
private struct ExampleGradientTrackStyle: AppKitSliderTrackStyle {
  var colours: [Color]

  func makeAppKitTrack(configuration: Configuration) -> AppKitSliderTrack {
    AppKitSliderTrack.linearGradient(colours.map(ResolvedTrackColour.init))
  }
}

private struct ExampleOpacityTrackStyle: AppKitSliderTrackStyle {
  var colour: Color

  func makeAppKitTrack(configuration: Configuration) -> AppKitSliderTrack {
    AppKitSliderTrack.opacityGradient(ResolvedTrackColour(colour))
  }
}

private struct ExampleLayeredTrackStyle: AppKitSliderTrackStyle {
  func makeAppKitTrack(configuration: Configuration) -> AppKitSliderTrack {
    AppKitSliderTrack(
      layers: [
        .checkerboard(
          .init(
            primary: .init(white: 0.94),
            secondary: .init(white: 0.72),
            squareLength: 5.0,
          )
        ),
        .linearGradient([
          .init(colour: .clear, location: 0.0),
          .init(colour: ResolvedTrackColour(configuration.tint), location: 1.0),
        ]),
      ],
      stroke: .init(white: 0.0, alpha: 0.24),
    )
  }
}
#endif

#if DEBUG
#Preview(traits: .size(.normal)) {
  SliderExamples()
}
#endif


