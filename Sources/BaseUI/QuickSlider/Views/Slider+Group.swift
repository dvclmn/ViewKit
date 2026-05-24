//
//  SliderGroup.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/5/2025.
import CoreTools
import ViewTools
import SwiftUI

public struct SliderGroup<Sliders: View>: View, ValueFormattable {
  @Environment(\.layoutSpacing) private var layoutSpacing
  let title: String?
  let verticalSpacing: CGFloat?
  let content: Sliders

  public init(
    _ title: String? = nil,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Sliders
  ) {
    self.title = title
    self.verticalSpacing = spacing
    self.content = content()
  }
  public var body: some View {

    if let title {
      Text(title)
        .font(.body)
        .foregroundStyle(.secondary)
    }
    Grid(
      alignment: .topLeading,
      verticalSpacing: spacing
    ) {
      content
        .environment(\.isWithinSliderGroup, true)
    }
    //    .padding(.bottom, Styles.sizeMedium)
  }
}

extension SliderGroup {

  /// This controls the spacing between Grid Rows in a Slider Group
  private var spacing: CGFloat? {
    let base = verticalSpacing ?? layoutSpacing
    //    return base
    return base.map { $0 * 1.3 }
  }
}
