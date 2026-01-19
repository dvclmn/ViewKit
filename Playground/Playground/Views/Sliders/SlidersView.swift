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
  @State private var testDebugMode: Bool = false
  
  @State private var value: Double = 5
  var body: some View {

    VStack(alignment: .trailing) {
      Group {
        TextScrubber(
          "Radius",
          value: $value,
          range: 1...30,
        )
        .isDebugMode(false)
        
        TextScrubber(
          "Debug scrubber",
          value: $value,
          range: 1...30,
        )
        .formatValue { $0.displayString(places: 0) }
        .isDebugMode(testDebugMode)
      } // END group
      .padding(24)
      

      Form {
        TextScrubber(
          "Radius",
          value: $value,
          range: 1...30,
        )
        .isDebugMode(false)
//        .environment(\.fractionLength, 2)
//        .formatValue { $0.displayString(places: 0) }
        
        TextScrubber(
          "Option held",
          value: $value,
          range: 1...30,
        )
        .isDebugMode(testDebugMode)
//        .environment(\.fractionLength, 2)
        
        Text("Plain Text view")
        
        LabeledContent("Labeled Item") {
          Picker("A Picker example", selection: .constant(ExampleTab.blarm)) {
            ForEach(ExampleTab.allCases) { tab in
              Text(tab.name).tag(tab)
            }
          }
          .labelsHidden()
        }
        TextField("TextField label", text: .constant("And some example contents"))
        
      }
      .formStyle(.grouped)
    }
    .padding(.top, 40)
    
    .onAppear {
      sleepyTask { @MainActor in
        self.testDebugMode = true
      }
    }
//    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  }
}

extension SlidersDemoView {

}
#if DEBUG
#Preview(traits: .size(.narrow)) {
  //  @Previewable @State var store = AppHandler()
  SlidersDemoView()
    .background(Color.black.quaternary)
  //    .environment(store)
}
#endif
