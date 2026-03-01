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

  let width: Int?
  let height: Int?
  let alignment: Alignment

  func body(content: Content) -> some View {
    content
      .frame(
        width: length(from: width),
        height: length(from: height),
        alignment: alignment
      )
  }
}
extension GridFrameModifier {
  private func length(from value: Int?) -> CGFloat? {
    guard let value else { return nil }
    return value.toScreenLength(along: .horizontal, using: asciiUnitSize)
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
    width: Int? = nil,
    height: Int? = nil,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      GridFrameModifier(
        width: width,
        height: height,
        alignment: alignment
      )
    )
  }

  public func gridFrame(
    minWidth: Int? = nil,
    idealWidth: Int? = nil,
    maxWidth: Int? = nil,
    minHeight: Int? = nil,
    idealHeight: Int? = nil,
    maxHeight: Int? = nil,
    alignment: Alignment = .center,
  ) -> some View {
    self.modifier(
      GridFrameMinMaxModifier(
        minWidth: minWidth,
        idealWidth: idealWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        idealHeight: idealHeight,
        maxHeight: maxHeight,
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
