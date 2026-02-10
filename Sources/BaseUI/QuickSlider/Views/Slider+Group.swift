//
//  SliderGroup.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/5/2025.
//

import CoreTools
import SwiftUI

public struct SliderGroup<Sliders: View>: View, ValueFormattable {
  @Environment(\.layoutSpacing) private var layoutSpacing
  let title: String?
  let verticalSpacing: CGFloat?
  let content: Sliders

  public init(
    _ title: String? = nil,
//    verticalSpacing: CGFloat? = Styles.sizeSmall,
    verticalSpacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Sliders
  ) {
    self.title = title
    self.verticalSpacing = verticalSpacing
    self.content = content()
  }
  public var body: some View {

    Grid(
      alignment: .leading,
      verticalSpacing: verticalSpacing ?? layoutSpacing
    ) {
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
