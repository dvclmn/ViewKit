//
//  HBarExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/5/2025.
//

import CoreTools
import ViewTools
import SwiftUI
// import LayoutKit
// import BaseTools
//import UIPrimitives

public struct InfoBarExampleView: View {

  //  let store = SampleContent.ExampleDataStore()
  @State private var value: Double = 0.3

  public var body: some View {

    VStack {

      VStack {
        QuickSlider(
          "Normal Mode",
          value: $value.toBindingDouble,
          range: .unitRange.toDoubleRange
        )
//        .environment(\.isASCIIMode, false)

        QuickSlider(
          "ASCII Mode",
          value: $value.toBindingDouble,
          range: .unitRange.toDoubleRange
        )

        

      }
      .frame(minHeight: 400)
      .padding(60)

      //        .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.black.secondary)
      .background(.purple.quinary)
      .infoBarValue(
        value,
        label: LabelDescriptor("Value", symbol: "slider.horizontal.3")
      ) { value in
        value.formatted(.number.precision(.fractionLength(3)))
      }
//      .infoBarItem(value) { value in
//        ProgressView(value: value)
//          .frame(width: 80)
//      }
      .infoBarView()
    }
  }
}

//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  InfoBarExampleView()
//    .frame(width: 400, height: 600)
//    .environment(\.isASCIIMode, true)
////    .onAppear {
////      let _ = BundledFonts.registerAll()
////    }
//}
//#endif
