//
//  BoundFloatSlider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI
import CoreTools

public struct BoundFloatSlider<T: BinaryFloatingPoint>: View where T: SliderFloat {
  // @Environment(AppHandler.self) private var store
  // @Environment(\.viewportSize) private var viewportSize
  let title: String
  @Binding var boundFloat: BoundFloat<T>
  
  public init(
    title: String,
    boundFloat: Binding<BoundFloat<T>>
  ) {
    self.title = title
    self._boundFloat = boundFloat
  }
  public var body: some View {
    
    QuickSlider<T>(
      title,
      value: $boundFloat.value,
      range: boundFloat.range,
      step: boundFloat.step,
    )
    
  }
}

extension BoundFloatSlider {
  
}
#if DEBUG
#Preview(traits: .size(.normal)) {
  // @Previewable @State var store = AppHandler()
  BoundFloatSlider()
  // .environment(store)
}
#endif
