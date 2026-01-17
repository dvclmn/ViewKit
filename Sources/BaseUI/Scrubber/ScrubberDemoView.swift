//
//  SrubberDemoView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import SwiftUI

struct ScrubberDemoView: View {
  @State private var value: Double = 2.0
  var body: some View {

    Scrubber(
      $value,
      range: 1...10,
      digitCount: 10,
      dragSensitivity: 0.4,
      formatted: { val in
        "Formatted: \(val.displayString(places: 0))"
      },
      onDoubleTap: {
        print("Double Tapped")
      }
    )
    .padding(40)
    .frame(width: 600, height: 700)
    .background(.black.opacity(0.6))

  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  ScrubberDemoView()
}
#endif
