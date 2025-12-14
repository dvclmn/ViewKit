//
//  HoverEffectExample.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import SwiftUI

@available(macOS 14.0, *)
struct HoverEffectExampleView: View {

  var body: some View {

    Text("Hello")
      .padding(80)
      .quickBackground()

      .hover3DEffect()
      .padding(140)

  }
}
#if DEBUG
  @available(macOS 15, iOS 18, *)
  #Preview(traits: .size(.normal)) {
    HoverEffectExampleView()
  }
#endif
