//
//  ControlsView.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import SwiftUI

@available(macOS 14.0, *)
extension ActionLinesView {
  
  @ViewBuilder
  func ActionControlsView() -> some View {
fatalError("Need to change approach, so hooks are provided, for the caller to use their own sliders, to avoid a dependancy between this and BaseUI")
//    ScrollView {
//      VStack(spacing: 16) {
//        GroupBox("Basic Parameters") {
//          VStack(alignment: .leading, spacing: 8) {
//
//            Picker("Boundary Shape", selection: $handler.lines.boundaryShape) {
//              ForEach(BoundaryShape.allCases, id: \.self) { shape in
//                Text(shape.name).tag(shape)
//              }
//            }
//            .pickerStyle(.segmented)
//
//            //            HStack {
//            //              Text("Random Seed")
//            //              Stepper(value: Binding(
//            //                get: { Double(handler.randomiser.randomSeed) },
//            //                set: { handler.randomiser.randomSeed = UInt64($0) }
//            //              )) {
//            //                Text("\(handler.randomiser.randomSeed)")
//            //              }
//            //            }
//
//            //            Button("Reset Randomization") {
//            //              handler.randomiser.resetRandomization()
//            //            }
//
//            ForEach(ActionLineParameter.allCases) { parameter in
//              QuickSlider(
//                parameter.name,
//                value: Binding(
//                  get: {
//                    handler.lines[keyPath: parameter.keyPath]
//                  },
//                  set: {
//                    handler.lines[keyPath: parameter.keyPath] = $0
//                  }
//                ), range: parameter.range)
//              //              LabeledSlider(value: Binding(
//              //                get: {
//              //                  handler.lines[keyPath: parameter.keyPath]
//              //                },
//              //                set: {
//              //                  handler.lines[keyPath: parameter.keyPath] = $0
//              //                }
//              //              ), range: parameter.range, label: parameter.name)
//            }
//          }
//          .padding(.vertical, 8)
//        }
//
//      }
//    }
  }
}
