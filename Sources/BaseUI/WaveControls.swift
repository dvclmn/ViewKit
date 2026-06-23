//
//  WaveControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI
import CoreTools
import ViewTools
import GraphicsKit
import WaveKit
//import UIPrimitives
//import VectorKit

//#warning("Pobrbaly need to bring this back")
public struct WaveControls: View {
  let title: String
  @Binding var wave: ConfiguredWave
  let ranges: (WaveAttribute) -> ClosedRange<Double>?

  public init(
    _ title: String,
    wave: Binding<ConfiguredWave>,
    ranges: @escaping (WaveAttribute) -> ClosedRange<Double>? = { _ in nil }
  ) {
    self.title = title
    self._wave = wave
    self.ranges = ranges
  }
  public var body: some View {

    SliderGroup {
      Wave(.amplitude)
      Wave(.frequency)
      Wave(.phase)
      //      Wave(.noise)

      Divider()

      Wave(.cycles)
        
    }
  }
}

extension WaveControls {
  @ViewBuilder
  private func Wave(_ attribute: WaveAttribute) -> some View {
    QuickSlider(
      attribute.name.abbreviated,
      value: $wave.waveBinding(attribute),
      range: ranges(attribute) ?? attribute.defaultRange
    )
    .stepStyle(.stepper)
    .formatValue {
      $0.render(using: .init(decimalPlaces: 1))
    }
    .labelTextCase(.uppercase)
    .labelWeight(.semibold)
    .labelColour(.secondary)
    .labelFontStyle(.callout)

  }
}

extension Binding where Value == ConfiguredWave {
  func waveBinding(_ attribute: WaveAttribute) -> Binding<Double> {
    Binding<Double> {
      wrappedValue[keyPath: attribute.keyPath]
    } set: {
      wrappedValue[keyPath: attribute.keyPath] = $0
    }

  }
}
