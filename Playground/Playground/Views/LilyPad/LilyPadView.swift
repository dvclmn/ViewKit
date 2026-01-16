//
//  LilyPadView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import GestureKit
import SwiftUI
import ToolKit

struct LilyPadDemoView: View {
  //  @Environment(AppHandler.self) private var store
  @State private var pressure: String = "No pressure"
  @State private var touches: String = "No touches"

  var body: some View {

    Text("Hello")
      .padding(40)
      .frame(width: 600, height: 700)
      .touches(
        isEnabled: true,
        mapStrategy: .fill,
        showIndicators: true
      ) { touches in
        self.touches = touches.reduce(
          into: "",
          { partialResult, point in
            partialResult +=
              DisplayString {
                Labeled("Position", value: point.position.displayString)
                Labeled("Velocity", value: point.velocity.displayString)
                Labeled("Magnitude", value: point.magnitude.displayString)
              }.text
          })
      } didUpdatePressure: { pressure in
        self.pressure = pressure.displayString
      }

      .debugTextOverlay(pressure, touches)
  }
}
#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  LilyPadDemoView()
    .environment(store)
}
#endif
