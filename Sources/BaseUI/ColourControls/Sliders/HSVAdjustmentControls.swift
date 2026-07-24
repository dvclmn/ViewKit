//
//  HSVAdjustmentControls.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/7/2026.
//

import ColourTools
import Foundation
import SwiftUI
import ViewTools

/// Sliders for editing the relative channels of an ``HSVAdjustment``.
///
/// Unlike ``HSVSliders``, these controls edit signed deltas rather than an
/// absolute colour. Hue is presented in degrees, while saturation and
/// brightness use their `-1...1` delta convention. A channel's leading button
/// controls whether this adjustment contributes to that axis: removing a
/// channel writes `nil`; enabling it writes an explicit neutral `0`.
/// While this editor remains alive, an excluded channel displays and restores
/// its most recent delta rather than discarding it.
///
/// The default ranges suit ColourTools' built-in modifiers, but they are an
/// editor policy rather than a constraint imposed by ``HSVAdjustment``.
public struct HSVAdjustmentSliders: View {
  @Binding private var adjustment: HSVAdjustment
  /// Retains a channel's last delta while that channel is excluded from the
  /// bound adjustment.
  @State private var rememberedChannels: HSVAdjustment

  private let hueDegreesRange: ClosedRange<Double>
  private let saturationRange: ClosedRange<Double>
  private let brightnessRange: ClosedRange<Double>

  public init(
    _ adjustment: Binding<HSVAdjustment>,
    hueDegreesRange: ClosedRange<Double> = -360...360,
    saturationRange: ClosedRange<Double> = -1...1,
    brightnessRange: ClosedRange<Double> = -1...1,
  ) {
    precondition(hueDegreesRange.contains(0), "A hue adjustment range must contain zero.")
    precondition(saturationRange.contains(0), "A saturation adjustment range must contain zero.")
    precondition(brightnessRange.contains(0), "A brightness adjustment range must contain zero.")

    self._adjustment = adjustment
    self._rememberedChannels = State(initialValue: adjustment.wrappedValue)
    self.hueDegreesRange = hueDegreesRange
    self.saturationRange = saturationRange
    self.brightnessRange = brightnessRange
  }

  public var body: some View {
    HSVAdjustmentChannel(
      "Hue",
      value: hueDegrees,
      isIncluded: includesChannel(\.hue),
      range: hueDegreesRange,
      //      step: 1,
      formatter: .degrees,
    )

    HSVAdjustmentChannel(
      "Saturation",
      value: channelValue(\.saturation),
      isIncluded: includesChannel(\.saturation),
      range: saturationRange,
      //      step: 0.01,
      formatter: .delta,
    )

    HSVAdjustmentChannel(
      "Brightness",
      value: channelValue(\.brightness),
      isIncluded: includesChannel(\.brightness),
      range: brightnessRange,
      //      step: 0.01,
      formatter: .delta,
    )
  }
}

extension HSVAdjustmentSliders {
  /// Presents the stored hue delta in degrees while retaining turns in the
  /// ColourTools model.
  private var hueDegrees: Binding<Double> {
    Binding(
      get: { (adjustment.hue ?? rememberedChannels.hue ?? 0) * 360 },
      set: { degrees in
        let turns = degrees / 360
        adjustment.hue = turns
        rememberedChannels.hue = turns
      },
    )
  }

  private func channelValue(
    _ keyPath: WritableKeyPath<HSVAdjustment, Double?>
  ) -> Binding<Double> {
    Binding(
      get: { adjustment[keyPath: keyPath] ?? rememberedChannels[keyPath: keyPath] ?? 0 },
      set: { value in
        adjustment[keyPath: keyPath] = value
        rememberedChannels[keyPath: keyPath] = value
      },
    )
  }

  private func includesChannel(
    _ keyPath: WritableKeyPath<HSVAdjustment, Double?>
  ) -> Binding<Bool> {
    Binding(
      get: { adjustment[keyPath: keyPath] != nil },
      set: { isIncluded in
        if isIncluded {
          adjustment[keyPath: keyPath] = rememberedChannels[keyPath: keyPath] ?? 0
        } else {
          rememberedChannels[keyPath: keyPath] = adjustment[keyPath: keyPath]
          adjustment[keyPath: keyPath] = nil
        }
      },
    )
  }
}


private extension ValueFormatter {
  static let degrees = ValueFormatter { value in
    String(format: "%+.0f°", value)
  }
  
  static let delta = ValueFormatter { value in
    String(format: "%+.2f", value)
  }
}


#if DEBUG
#Preview {
  @Previewable @State var adjustment = HSVAdjustment(
    hueDegrees: -18,
    saturation: nil,
    brightness: 0.35,
  )

  Form {
    HSVAdjustmentSliders($adjustment)
  }
  .formStyle(.grouped)
  .padding()
  .frame(maxWidth: 360)
}
#endif
