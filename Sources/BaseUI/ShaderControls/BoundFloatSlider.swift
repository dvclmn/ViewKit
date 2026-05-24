//
//  BoundFloatSlider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
import CoreTools
import ViewTools
import LayoutKit
import SwiftUI

public struct BoundFloatSlider: View {
  let title: String
  @Binding var boundFloat: BoundFloat<Double>

  public init(
    title: String,
    boundFloat: Binding<BoundFloat<Double>>
  ) {
    self.title = title
    self._boundFloat = boundFloat
  }
  public var body: some View {

    QuickSlider(
      title,
      value: $boundFloat.value,
      range: boundFloat.range,
      step: boundFloat.step,
    )

  }
}

//extension BoundFloatSlider {
//
//}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  // @Previewable @State var store = AppHandler()
//  BoundFloatSlider()
//  // .environment(store)
//}
//#endif
