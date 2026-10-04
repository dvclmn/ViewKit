//
//  QuickBackgroundExampleView.swift
//  ViewKit
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import SwiftUI
// import LayoutKit
import ViewTools

struct QuickBackgroundExampleView: View {

  let width: CGFloat = 400

  var body: some View {
    VStack(spacing: Styles.sizeMedium) {

      Text("Rounded Rect")
        .padding(40)
        .quickBackground(
          shape: .rect(cornerRadius: Styles.sizeRegular),
//          padding: Styles.sizeSmall,
//          tint: .pink,
          //          usesGlassEffect: true
        )

      Text("Capsule")
        .padding(40)
        .quickBackground(
          shape: .capsule,
//          padding: Styles.sizeMedium,
//          tint: .black,
          //          usesGlassEffect: false
        )
    }
    .environment(\.horizontalBias, 3)
    .environment(\.opticalCentreBias, 1.5)

    .padding(.vertical, 40)

    .halfImageDebugBackground()
    .frame(width: width)
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  QuickBackgroundExampleView()
}
#endif
