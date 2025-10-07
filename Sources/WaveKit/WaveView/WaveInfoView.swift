//
//  WaveInfoView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/8/2025.
//

import BaseUI
import BaseHelpers
import SwiftUI
import CurveKit

public struct WaveInfoView: View {

  @Environment(\.isEmphasised) private var isEmphasised

  let wave: Wave
  public var body: some View {

    DecomposedView(.subview, axis: .horizontal, spacing: Styles.sizeRegular) {
      //      HStack {
      WaveProperty("FREQ", value: wave.frequency.displayed)
      WaveProperty("AMP", value: wave.amplitude.displayed)

      if wave.phaseOffset.displayed != 0 {
        WaveProperty("PHASE", value: wave.phaseOffset.displayed)
      }
      //      }
    }

    //    HStack(spacing: Styles.sizeRegular) {
    //    }

    .monospacedDigit()
    .padding(.horizontal, Styles.sizeTiny)
    .padding(.bottom, 1)
    //    .background(Color.brown)
    //    .quickBackground(.rect(cornerRadius: Styles.sizeMicro), backgroundTint: Color.black.opacity(0.5))

    //      .animation(Styles.animationSpringSubtle, value: isEmphasised)
  }

}
extension WaveInfoView {
  @ViewBuilder
  func WaveProperty(_ title: String, value: CGFloat) -> some View {
    HStack(alignment: .firstTextBaseline, spacing: Styles.sizeTiny) {
      Text(title)
        .font(.caption.weight(.medium))
        .foregroundStyle(.tertiary)
        .monospaced()

      Text(value.displayString(places: 1))
        .font(.callout.weight(.semibold))
        .foregroundStyle(.primary.opacity(0.8))
    }
  }
}
