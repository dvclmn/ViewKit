//
//  SystemPicker.swift
//  ViewKit
//
//  Created by Dave Coleman on 22/3/2026.
//

import CoreTools
import ViewTools
// import LayoutKit
import SwiftUI
import ColourTools

public struct SystemColourPicker: View {
  @Environment(\.self) private var envSelf

  @State private var localColour: Color

  let title: String
  @Binding var colour: RGBColour
  var opacity: Binding<Double>?
  let presets: [RGBColour]?

  public init(
    _ title: String,
    colour: Binding<RGBColour>,
    opacity: Binding<Double>? = nil,
    presets: [RGBColour]? = nil,
  ) {
    self.title = title
    self._localColour = State(initialValue: colour.wrappedValue.toColour)
    self._colour = colour
    self.opacity = opacity
    self.presets = presets
  }

  public var body: some View {

    ColorPicker(title, selection: $localColour, supportsOpacity: false)

      .task(id: localColour) {
        colour = RGBColour(
          colour: localColour,
          environment: envSelf,
          name: nil,
        )
      }

    if let presets {
      Presets(presets)
    }

    if let opacity {
      QuickSlider(
        "Opacity",
        value: opacity,
        range: .unitRange,
      )
      .formatValue(.percent)
    }

  }
}
extension SystemColourPicker {

  // TODO: Need a comparison with a small buffer, as this doesn't catch similar values properly
  private func isPresetSelected(_ preset: RGBColour) -> Bool {
    preset.toColour == colour.toColour
  }

  @ViewBuilder
  private func Presets(_ presets: [RGBColour]) -> some View {
    LabeledContent("Presets") {
      HStack {
        ForEach(presets) { preset in
          Button {
            localColour = preset.toColour
          } label: {
            Label(preset.name ?? "Color", systemImage: Icons.circle.icon)
              .labelStyle(.iconOnly)
              .symbolVariant(.fill)
              .foregroundStyle(preset.toColour)
              .font(.title2)
          }

        }
      }
    }
    .buttonStyle(.plain)
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {

  @Previewable @State var colour = RGBColour.aliceblue
  SystemColourPicker(
    "Hello",
    colour: $colour,
    opacity: .constant(0.2),
    presets: nil,
  )
}
#endif
