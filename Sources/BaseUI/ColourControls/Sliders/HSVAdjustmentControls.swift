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
///
/// The default ranges suit ColourTools' built-in modifiers, but they are an
/// editor policy rather than a constraint imposed by ``HSVAdjustment``.
public struct HSVAdjustmentSliders: View {
  @Binding private var adjustment: HSVAdjustment

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
      get: { (adjustment.hue ?? 0) * 360 },
      set: { adjustment.hue = $0 / 360 },
    )
  }

  private func channelValue(
    _ keyPath: WritableKeyPath<HSVAdjustment, Double?>
  ) -> Binding<Double> {
    Binding(
      get: { adjustment[keyPath: keyPath] ?? 0 },
      set: { adjustment[keyPath: keyPath] = $0 },
    )
  }

  private func includesChannel(
    _ keyPath: WritableKeyPath<HSVAdjustment, Double?>
  ) -> Binding<Bool> {
    Binding(
      get: { adjustment[keyPath: keyPath] != nil },
      set: { isIncluded in
        adjustment[keyPath: keyPath] =
          isIncluded
          ? adjustment[keyPath: keyPath] ?? 0
          : nil
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

