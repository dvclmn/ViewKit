//
//  SliderGroup.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/5/2025.
//


import SwiftUI

import BasePrimitives

public struct SliderGroup<Sliders: View>: View {
  //  @Environment(\.sliderControlSize) var sliderControlSize

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
          //          .textCase(.uppercase)
          .font(.callout.weight(.medium))
          .foregroundStyle(.secondary)
          .padding(.bottom, Styles.sizeSmall)
      }
      content
    }

  }
}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  SliderGroup()
//}
//#endif
//
