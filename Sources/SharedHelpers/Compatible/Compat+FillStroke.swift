//
//  Compat+FillStroke.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/12/2025.
//

import SwiftUI

//@available(macOS 14.0, *)
//extension Shape {
//  public func fillCompatible<S>(_ content: S) -> some View where S: ShapeStyle {
//    if #available(iOS 17.0, macOS 14.0, *) {
//
//      let thing = self.fill(content)
//      return thing
//    } else {
//      let thing = self.fill(cont)
//      self
//    }
//
////    } else {
////      self.fill(content)
////    }
//  }
//}

//public struct FillCompatible<S: Shape>: ViewModifier {
//
//  let shape: S
//  public func body(content: Content) -> some View {
//    if #available(iOS 17.0, macOS 14.0, *) {
//      content
//    } else {
//      content
//
//    }
//  }
//}
//extension View {
//  public func fillShape<S>(_ shape: S) -> some View {
//    self.modifier(FillCompatible())
//  }
//}

public struct FilledShape<S: InsettableShape, Style: ShapeStyle>: View {
  let shape: S
  let content: Style
  let strokeColour: AnyShapeStyle?
  let lineWidth: CGFloat

  public init(
    _ shape: S,
    _ content: Style,
    strokeColour: AnyShapeStyle? = nil,
    lineWidth: CGFloat = 1.0
  ) {
    self.shape = shape
    self.content = content
    self.strokeColour = strokeColour
    self.lineWidth = lineWidth
  }
  
  public init(
    _ shape: S,
    _ content: Style,
    strokeColour: Color? = nil,
    lineWidth: CGFloat = 1.0
  ) {
    self.shape = shape
    self.content = content
    self.strokeColour = strokeColour.map { $0.toShapeStyle }
    self.lineWidth = lineWidth
  }

  public var body: some View {
    if #available(iOS 17.0, macOS 14.0, *) {
      shape
        .fill(content)
        .stroke(strokeColour ?? AnyShapeStyle.clear, lineWidth: lineWidth)

    } else {
      shape
        .strokeBorder(strokeColour ?? AnyShapeStyle.clear, lineWidth: lineWidth)
        .background(shape.fill(content))
      //        .stroke(strokeColour ?? AnyShapeStyle.clear, lineWidth: lineWidth)
      //      .background(Circle().foregroundColor(Color.red))
      //      shape
      //        .fill(content)
      //
      //      shape
      //        .stroke(strokeColour ?? AnyShapeStyle.clear, lineWidth: lineWidth)
    }
  }
}
