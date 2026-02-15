//
//  QuickBackgroundExampleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import SwiftUI

struct QuickBackgroundExampleView: View {

  var body: some View {
    VStack(spacing: Styles.sizeMedium) {

      Text("Rounded Rect")
        .padding(40)
        .quickBackground(
          shape: .rect(cornerRadius: Styles.sizeRegular),
          padding: Styles.sizeSmall,
          tint: .pink,
        )

      Text("Capsule")
        .padding(40)
        .quickBackground(
          shape: .capsule,
          padding: Styles.sizeMedium,
          tint: .black,
        )
    }
    .environment(\.horizontalBias, 3)
    .environment(\.opticalCentreBias, 1.5)
    .padding(20)
    .background(Color.black.secondary)
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  QuickBackgroundExampleView()
}
#endif
