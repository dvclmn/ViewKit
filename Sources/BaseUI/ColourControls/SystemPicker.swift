//
//  SystemPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/3/2026.
//

import BasePrimitives
import LayoutKit
import SwiftUI

public struct SystemColourPicker: View {
  @Environment(\.self) private var envSelf

  @State private var localGridLineColour: Color

  let title: String
  @Binding var colour: RGBColour
  var opacity: Binding<Double>?
  let presets: [RGBColour]?

  public init(
    _ title: String,
    colour: Binding<RGBColour>,
    opacity: Binding<Double>? = nil,
    presets: [RGBColour]? = nil
  ) {
    self.title = title
    self._localGridLineColour = State(initialValue: colour.wrappedValue.toColour)
    self._colour = colour
    self.opacity = opacity
    self.presets = presets
  }

  public var body: some View {

    ColorPicker(title, selection: $localGridLineColour, supportsOpacity: false)

      .task(id: localGridLineColour) {
        colour = RGBColour(
          colour: localGridLineColour,
          environment: envSelf,
          name: nil
        )
      }

    if let presets {
      Presets(presets)
    }

    if let opacity {
      //    if showsOpacitySlider {
      QuickSlider(
        "Opacity",
        value: opacity,
        //        value: Binding(store.$preferences.gridLines.opacity).toBindingDouble,
        range: .unitRange
      )
      .formatValue(.percent)
    }

  }
}
extension SystemColourPicker {

  // TODO: Need a comparison with a small buffer, as this doesn't catch similar values properly
  private func isPresetSelected(_ preset: RGBColour) -> Bool {
    preset.toColour == colour.toColour
//    guard let presets else { return false }
//        return presets.contains(where: { $0 == preset })
//    return presets.contains(where: { $0.toColour == localGridLineColour })
  }

  @ViewBuilder
  private func Presets(_ presets: [RGBColour]) -> some View {
    LabeledContent("Presets") {
      HStack {
        ForEach(presets) { preset in
          Button {
            localGridLineColour = preset.toColour
          } label: {
            Label(preset.name ?? "Color", systemImage: Icons.circle.icon)
              .labelStyle(.iconOnly)
              .symbolVariant(.fill)
              .foregroundStyle(preset.toColour)
              .font(.title2)

//              .padding(isPresetSelected(preset) ? 2 : 0)
//              .overlay {
//                if isPresetSelected(preset) {
//                  Circle()
//                    .fill(.clear)
//                    .stroke(Color.accentColor, lineWidth: 3)
//                }
//              }
          }

        }
      }
    }
    .buttonStyle(.plain)
  }
}
