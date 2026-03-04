//
//  SliderCustomExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI
import CoreTools
import ColourKit

public struct SliderExamples: View {

  @State private var zoomValue: CGFloat = 2.0
  private let zoomRange: ClosedRange<CGFloat> = 0.1...20

  public var body: some View {
    VStack(spacing: Styles.sizeMedium) {

      SliderGroup("Group title") {

        QuickSlider(
          "Simple Slider",
          value: $zoomValue.toBindingDouble,
          range: zoomRange.toDoubleRange,
        )
//        .sliderStyle(.native, components: .noLabel)
        //      .padding()
        //      .background(.mint.quinary)

        QuickSlider(
          "Opacity Slider",
          value: $zoomValue.toBindingDouble,
          range: zoomRange.toDoubleRange,
        )
        .sliderStyle(.custom(.opacityCheckboard(RGBColour.bisque)))
        .environment(\.sliderDefaultValue, 1.0)

        //      .setExplicitHeight(5)
        //      .environment(\.heightOverride, 5)
//        .environment(\.trackComponents, [.thumb])
        //      .padding()
        //      .background(.purple.quinary)

        QuickSlider(
          "No Units",
          value: $zoomValue.toBindingDouble,
          range: zoomRange.toDoubleRange,
        )
//        .environment(\.sliderComponents, [.slider, .label])
        //      .padding()
        //      .background(.yellow.quinary)

        QuickSlider(
          "Compact",
          value: $zoomValue.toBindingDouble,
          range: zoomRange.toDoubleRange,
        )
        .sliderStyle(.native)
        .sliderComponents([.track, .thumb])
        .gridCellColumns(3)
        //      .environment(\.heightOverride, 20)
        //      .padding()
        //      .background(.brown.quinary)

        
        //      .environment(\.heightOverride, 34)
        //      .padding()
        //      .background(.blue.quinary)

      }
      .formatValue { $0.displayString(places: 1) }
      .environment(\.maxCharacterColumns, 4)
      //    .formStyle(.grouped)
      
      Divider()

      QuickSlider(
        "Bar Slider",
        value: $zoomValue.toBindingDouble,
        range: zoomRange.toDoubleRange,
      )
      .sliderStyle(.custom(.clear))
      .sliderComponents([.track, .units])
    } // END main vstack
    .padding()
    .frame(maxWidth: 320)
//    .isDebugMode(true)

  }
}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  SliderExamples()
}
#endif

//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  @Previewable @State var value: Double = 2.6
//
//  VStack {
//    Form {
//      Section("Slider Preview") {
//        QuickSlider(
//          "First",
//          value: $value,
//          range: 0.1...20,
//          //          defaultValue: 2.2,
//        )
//        .environment(\.sliderDefaultValue, 2.2)
//
//        QuickSlider(
//          "Second",
//          value: $value,
//          range: 0.1...20,
//          //          defaultValue: 2.2,
//
//        )
//        .environment(\.sliderDefaultValue, 2.2)
//
//        QuickSlider(
//          "Third (no label)",
//          value: $value,
//          range: 0.1...20,
//          //          defaultValue: 2.2,
//
//        )
//      }
//    }
//    .formStyle(.grouped)
//
//    VStack {
//      QuickSlider(
//        "Fourth",
//        value: $value,
//        range: 1...10,
//        //        defaultValue: 5.0,
//      )
//      .environment(\.sliderDefaultValue, 2.2)
//
//      QuickSlider(
//        "Fifth",
//        value: $value,
//        range: 1...10,
//        //        defaultValue: 8.0,
//
//      )
//
//      QuickSlider(
//        "Sixth (no label)",
//        value: $value,
//        range: 1...10,
//        //        defaultValue: 8.0,
//
//      )
//    }
//    .padding()
//    .frame(minHeight: 300)
//    .background(.brown.quinary)
//
//  }
//  .frame(maxWidth: 400)
//  //  .setViewModes(.compact)
//  //    .padding(80)
//  //    .quickBackground()
//}
//#endif
