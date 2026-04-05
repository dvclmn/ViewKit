//
//  TextRenderer.swift
//  Collection
//
//  Created by Dave Coleman on 6/11/2024.
//

import SwiftUI

extension View {
  @ViewBuilder public func textRendererCompatible<T>(
    _ renderer: T
  ) -> some View where T: TextRenderer {
    if #available(macOS 15.0, iOS 18.0, *) {
      textRenderer(renderer)
    } else {
      self
    }
  }
}

extension Text.Layout {
  public var flattenedRunSlices: some RandomAccessCollection<Text.Layout.RunSlice> {
    flattenedRuns.flatMap(\.self)
  }
  
  public var flattenedRuns: some RandomAccessCollection<Text.Layout.Run> {
    flatMap(\.self)
  }
}

//public struct TextRender<T: TextRenderer>: ViewModifier {
//
//  let renderer: T
//  public func body(content: Content) -> some View {
//
//    if #available(macOS 15, iOS 18, *) {
//      content
//        .textRenderer(renderer)
//    } else {
//      content
//    }
//  }
//}
//
//extension View where Self == Text {
//  public func renderText<T: TextRenderer>(_ renderer: T) -> some View {
//    self.modifier(
//      TextRender(renderer: renderer)
//    )
//  }
//}
//

