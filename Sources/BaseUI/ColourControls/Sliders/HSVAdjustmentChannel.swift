//
//  HSVAdjustmentChannel.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/7/2026.
//

import SwiftUI
import ViewTools

struct HSVAdjustmentChannel: View {
  let title: String
  @Binding var value: Double
  @Binding var isIncluded: Bool
  let range: ClosedRange<Double>
  let step: Double?
  let formatter: ValueFormatter
  
  init(
    _ title: String,
    value: Binding<Double>,
    isIncluded: Binding<Bool>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    formatter: ValueFormatter,
  ) {
    self.title = title
    self._value = value
    self._isIncluded = isIncluded
    self.range = range
    self.step = step
    self.formatter = formatter
  }
  
  var body: some View {
    HStack(spacing: 6) {
      Button {
        isIncluded.toggle()
      } label: {
        Image(systemName: isIncluded ? "checkmark.circle.fill" : "circle")
          .foregroundStyle(.tint.opacity(isIncluded ? 1 : 0.3))
        //          .foregroundStyle(isIncluded ? .tint : .secondary)
      }
      .buttonStyle(.plain)
      .accessibilityLabel(isIncluded ? "Remove \(title) adjustment" : "Include \(title) adjustment")
      
      QuickSlider(
        title,
        value: $value,
        range: range,
        step: step,
        neutralValue: 0,
      )
      .disabled(!isIncluded)
      .opacity(isIncluded ? 1 : 0.45)
      .formatValue(formatter)
      .environment(\.sliderDefaultValue, 0)
    }
  }
}
