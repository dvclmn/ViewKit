//
//  TextSliderCore.swift
//  DrawString
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

#warning("Needs work to hook up a handler, etc")
//@Observable
//final class TextSliderHandler {
//
//}

//struct TextSliderCore: View {
//  @Environment(SliderHandler.self) private var store
//  // @Environment(AppHandler.self) private var store
//  // @Environment(\.viewportSize) private var viewportSize
//
//  let value: Double
//  let unitSize: CGSize
//  //  let range: ClosedRange<Double>
//  //  let width: Int
//  //  let columns: Int
//
//  var body: some View {
//
//    VStack(spacing: 0) {
//      Text(sliderRepresentation())
//        .gridFont(for: .asciiMode)
//      //        .gridFont(for: .interface)
//    }
//    .frame(width: sliderFullWidth)
//
//  }
//}
//
//extension TextSliderCore {
//  private var columns: Int { store.sliderTrackColumns }
//
//  var sliderFullWidth: CGFloat { CGFloat(store.width) * unitSize.width }
//
//  private func sliderRepresentation() -> String {
//
//    let normalisedValue = (value - store.range.lowerBound) / (store.range.upperBound - store.range.lowerBound)
//    let filledWidth = Int(normalisedValue * Double(columns))
//    let subCellPosition = (normalisedValue * Double(columns) - Double(filledWidth)) * 4
//
//    var representation = "┌" + String(repeating: "─", count: columns) + "┐\n│"
//
//    for i in 0..<columns {
//      if i < filledWidth {
//        representation += "█"
//      } else if i == filledWidth {
//        representation += store.cellCharacters[min(Int(subCellPosition), 3)]
//      } else {
//        representation += " "
//      }
//    }
//
//    representation += "│\n└" + String(repeating: "─", count: columns) + "┘\n"
//
//    //    if representation.count > width {
//    //      fatalError("`representation.count` ( \(representation.count) ) can't exceed containing width of \(width)")
//    //    }
//
//    return representation
//  }
//
//}
