//
//  TextSlider.swift
//  DrawString
//
//  Created by Dave Coleman on 27/8/2024.
//

//import SwiftUI
//
//struct TextSlider: View {
//  @Environment(\.unitSize) private var unitSize
//
//  typealias Output = (CGFloat) -> Void
//
//  @Binding var value: CGFloat
//  let range: ClosedRange<Double>
//  let width: Int
//  //  let cellSize: CGSize
//  let onChanged: Output
//  let onEnded: Output
//
//  @State private var isDragging = false
//  @State private var dragStartLocation: CGPoint?
//
//  //  @State private var sliderDimensions: CGSize = .defaultCellSize
//
////  private let cellCharacters = ["░", "▒", "▓", "█"]
//
//  init(
//    value: Binding<CGFloat>,
//    range: ClosedRange<Double>,
//    width: Int,
//    //    cellSize: CGSize,
//    onChanged: @escaping Output = { _ in },
//    onEnded: @escaping Output = { _ in }
//  ) {
//    self._value = value
//    self.range = range
//    self.width = width
//    //    self.cellSize = cellSize
//    self.onChanged = onChanged
//    self.onEnded = onEnded
//  }
//
//  var body: some View {
//    if let unitSize {
//      TextSliderCore(
//        unitSize: unitSize,
//        range: range,
//        width: width,
//        columns: sliderTrackColumns
//      )
//      .gesture(
//        DragGesture(minimumDistance: 0)
//          .onChanged { gesture in
//            if !isDragging {
//              isDragging = true
//              dragStartLocation = gesture.startLocation
//              value = calculateValue(at: gesture.location, along: sliderTrackWidth)
//            } else {
//              value = calculateValue(at: gesture.location, along: sliderTrackWidth)
//              onChanged(value)
//            }
//          }
//          .onEnded { gesture in
//            isDragging = false
//            dragStartLocation = nil
//
//            let finalValue = calculateValue(at: gesture.location, along: sliderTrackWidth)
//            onEnded(finalValue)
//          }
//      )
//    }
//
//  }
//}
//
//extension TextSlider {
//  
//
//  var sliderTrackWidth: CGFloat {
//    CGFloat(sliderTrackColumns) * unitSize.width
//  }
//
//  private func calculateValue(
//    at location: CGPoint,
//    along width: CGFloat
//  ) -> CGFloat {
//
//    let normalisedX = max(0.01, min(location.x, width)) / width
//
//    return range.lowerBound + (range.upperBound - range.lowerBound) * Double(normalisedX)
//  }
//}
