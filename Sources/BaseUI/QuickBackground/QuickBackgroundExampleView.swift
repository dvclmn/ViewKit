//
//  QuickBackgroundExampleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import SwiftUI
import CoreTools

struct QuickBackgroundExampleView: View {
  // @Environment(AppHandler.self) private var store
  // @Environment(\.viewportSize) private var viewportSize
  
  var body: some View {
    
    Text("Hello")
      .padding(40)
      .frame(width: 600, height: 700)
      .quickBackground(
        shape: .rect(cornerRadius: Styles.sizeSmall),
        padding: Styles.sizeRegular,
        hasOpticalAdjustment: true
      )
    
  }
}

extension QuickBackgroundExampleView {
  
}
#if DEBUG
#Preview(traits: .size(.normal)) {
  // @Previewable @State var store = AppHandler()
  QuickBackgroundExampleView()
  // .environment(store)
}
#endif
