//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import LayoutKit
import BaseUtilities
import SwiftUI

//public struct BoxFrameView<Content: View>: View {
//  @Environment(\.glyphSet) private var glyphSet
//  @Environment(\.frameStyle) private var frameStyle
//  @Environment(\.unitSize) private var unitSize
//
//  @State private var viewSize: CGSize?
//
//  let alignment: Alignment
//  let padding: GridDimensions
//  let content: Content
//
//  public init(
//    separator: String = "\n",
//    paddingH: Int = 0,
//    paddingV: Int = 0,
//    alignment: Alignment = .center,
//    @ViewBuilder content: @escaping () -> Content
//  ) {
//    self.alignment = alignment
//    self.padding = GridDimensions(paddingH, paddingV)
//    self.content = content()
//  }
//
//  public var body: some View {
//    content
//
//      /// Padding to seat content within Box view
////      .gridPadding(.horizontal, paddingAdjusted.width)
////      .gridPadding(.vertical, paddingAdjusted.height)
//
//      .viewSize(mode: .debounce(0.2)) { size in
//        updateIfChanged(&self.viewSize, to: size)
//      }
//
//      .background(.topLeading) {
//        BoxFrame()
//      }
//      .setGridFrame(
//        dimensions?.width,
//        dimensions?.height
//      )
//      .gridGuide(opacity: 0.2)
//
//  }
//}
//
//extension BoxFrameView {
//
//  /// Padding first needs to account for the width/height
//  /// taken up by structure, like the frame. As well as any
//  /// user-specified padding.
////  private var paddingAdjusted: GridDimensions {
////    let reserved = frameStyle.reservedDimensions
////    let user = self.padding
////    return reserved + user
////  }
//
//  private var boxText: String? {
//    guard let w = dimensions?.width, let h = dimensions?.height else { return nil }
//    
//    let text = Box(
//      width: w,
//      height: h,
//      theme: .default
//    ) {
//      Box.Divider()
//      "I'm txt as well"
//      Box.Bottom()
//    }.plainText
//
//    return text
//  }
//
//  @ViewBuilder
//  private func BoxFrame() -> some View {
//    if let boxText {
//      Text(boxText)
//        .fixedSize()
//    }
//    //      .frameFromGridSize(width: w, height: h, alignment: alignment)
//  }
//  private var dimensions: GridDimensions? {
//    guard let unitSize else { return nil }
//    return viewSize?.toGridDimensions(using: unitSize, rounding: .down)
//  }
//}
//
////#if DEBUG
////#Preview {
////
////  VStack(spacing: 14) {
////
////    BoxView {
////      Text("I'm a SwiftUI View")
////      Text(DummyContent.Strings.paragraphs[8].toAttributed)
////    }
////
////    //        .gridFrame(42)
////    //        .boxStyle(glyphs: .double, frame: .double)
////
////  }
////  .textSelection(.enabled)
////  .monospaced()
////  .frame(
////    minWidth: 400,
////    minHeight: 600
////  )
////  .background(.black.opacity(0.6))
////}
////#endif
