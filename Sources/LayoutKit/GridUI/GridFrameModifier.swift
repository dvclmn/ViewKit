//
//  GridFrameModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import CoreTools
import SwiftUI

struct GridFrameModifier: ViewModifier {
  @Environment(\.asciiUnitSize) private var asciiUnitSize

  let dimensions: GridDimensions
  let alignment: Alignment

  func body(content: Content) -> some View {
    content
      .frame(
        width: frameSize?.width,
        height: frameSize?.height,
        alignment: alignment
      )
  }
}
extension GridFrameModifier {
  private var frameSize: CGSize? {
    guard let asciiUnitSize else { return nil }
    return dimensions.toScreenSize(using: asciiUnitSize)
  }
}

struct GridFrameMinMaxModifier: ViewModifier {
  @Environment(\.asciiUnitSize) private var asciiUnitSize

  let minWidth: Int?
  let idealWidth: Int?
  let maxWidth: Int?
  let minHeight: Int?
  let idealHeight: Int?
  let maxHeight: Int?
  let alignment: Alignment

  func body(content: Content) -> some View {
    content
      .frame(
        minWidth: length(from: minWidth),
        idealWidth: length(from: idealWidth),
        maxWidth: length(from: maxWidth),
        minHeight: length(from: minHeight),
        idealHeight: length(from: idealHeight),
        maxHeight: length(from: maxHeight),
        alignment: alignment
      )
  }
}
extension GridFrameMinMaxModifier {
  private func length(from value: Int?) -> CGFloat? {
    guard let value else { return nil }
    return value.toScreenLength(along: .horizontal, using: asciiUnitSize)
  }
}

extension View {
  public func gridFrame(
    width: Int,
    height: Int,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      GridFrameModifier(
        dimensions: GridDimensions(width, height),
        alignment: alignment
      )
    )
  }
}

//public struct CanvasDimensionsModifier: ViewModifier {
//  @Environment(\.gridCanvas) private var gridCanvas
//
//  let element: GridElement
//  let scale: CGFloat
//  public func body(content: Content) -> some View {
//    content
//      .frame(
//        width: size.width,
//        height: size.height,
//      )
//  }
//}
//extension CanvasDimensionsModifier {
//  var size: CGSize {
//    let baseSize: CGSize = gridCanvas.wrappedValue[keyPath: element.keyPath]
//    return baseSize * scale
//  }
//}
//extension View {
//  public func gridFrame(
//    for element: GridElement = .canvas,
//    scale: CGFloat = 1.0
//  ) -> some View {
//    self.modifier(
//      CanvasDimensionsModifier(element: element, scale: scale)
//    )
//  }
//}

//public enum GridElement {
//  case canvas
//  case cell
//
//  var keyPath: KeyPath<GridCanvas, CGSize> {
//    switch self {
//      case .canvas: \.canvasSize
//      case .cell: \.cellSize
//    }
//  }
//}
