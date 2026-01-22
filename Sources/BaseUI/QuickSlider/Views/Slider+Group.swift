//
//  SliderGroup.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/5/2025.
//

import CoreTools
import SwiftUI

public struct SliderGroup<Sliders: View>: View, ValueFormattable {
  let title: String?
  let content: Sliders

  public init(
    _ title: String? = nil,
    @ViewBuilder content: @escaping () -> Sliders
  ) {
    self.title = title
    self.content = content()
  }
  public var body: some View {

    Grid(alignment: .leading) {
      if let title {
        Text(title)
          .font(.callout.weight(.medium))
          .foregroundStyle(.secondary)
          .padding(.bottom, Styles.sizeSmall)
      }
      content
        .environment(\.isWithinSliderGroup, true)
    }
  }
}
