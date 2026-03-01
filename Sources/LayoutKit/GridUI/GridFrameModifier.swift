//
//  GridFrameModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI
import CoreTools

struct GridFrameModifier: ViewModifier {
  @Environment(\.asciiModeFontSize) private var asciiModeFontSize
  
  let dimensions: GridDimensions
  let alignment: Alignment
  
  func body(content: Content) -> some View {
    content
//      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  }
}



extension View {
  public func gridFrame(width: Int, height: Int, alignment: Alignment) -> some View {
    self.frame(width: <#T##CGFloat?#>, height: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
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
