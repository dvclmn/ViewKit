//
//  LabeledSlider.swift
//  BaseComponents
//
//  Created by Dave Coleman on 16/8/2025.
//

import BasePrimitives
import SwiftUI

public struct LabeledSlider<Content: View>: View, SliderStylable {

  @Binding var value: Double
  let range: ClosedRange<Double>
  let label: QuickLabel
  let blurb: String?
  let type: SliderStyle
  let additionalContent: Content
  let didChangeSlider: SliderOutput
  /// Doesn't yet support passing through `didChangeSlider`
  
  public init(
    _ label: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    blurb: String? = nil,
    type: SliderStyle = .native,
    @ViewBuilder additionalContent: @escaping () -> Content = { EmptyView() },
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self._value = value
    self.range = range
    self.label = QuickLabel(label)
    self.blurb = blurb
    self.type = type
    self.additionalContent = additionalContent()
    self.didChangeSlider = didChangeSlider
  }

  public var body: some View {

    LabeledContent {
      VStack(spacing: Styles.sizeRegular.bump) {
        QuickSlider(
          label: label,
          value: $value,
          range: range,
          didChangeSlider: didChangeSlider
        )
        .labelsHidden()
        additionalContent
      }

    } label: {
      MaybeLabel(label)
      if let blurb {
        Text(blurb)
      }
    }

  }
}
