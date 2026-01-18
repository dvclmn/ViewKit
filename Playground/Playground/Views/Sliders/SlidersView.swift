//
//  SlidersView.swift
//  Playground
//
//  Created by Dave Coleman on 18/1/2026.
//

import SwiftUI
import ToolKit

struct SlidersDemoView: View {
  //  @Environment(AppHandler.self) private var store
  @State private var value: Double = 5
  var body: some View {

    TextScrubber(
      $value,
      range: 1...30,
      step: 5,
      dragSensitivity: 0.2
    )
    .formatValue { $0.displayString(places: 0) }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

extension SlidersDemoView {

}
#if DEBUG
#Preview(traits: .size(.normal)) {
  //  @Previewable @State var store = AppHandler()
  SlidersDemoView()
  //    .environment(store)
}
#endif
