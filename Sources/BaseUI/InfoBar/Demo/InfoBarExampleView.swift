//
//  HBarExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/5/2025.
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
      .safeAreaPadding(.bottom, Styles.infoBarHeight)
      .addInfoBarItems("Hello")
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
