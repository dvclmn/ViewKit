//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import LayoutKit
import CoreTools
import SwiftUI

//public struct HeaderBoxView: View {
//  @Environment(\.glyphSet) private var glyphSet
//  @Environment(\.frameStyle) private var frameStyle
//  @Environment(\.gridWidth) private var gridWidth
//  @Environment(\.gridHeight) private var gridHeight
//
//  @State private var characterSize: CGSize?
//
//  let title: String?
//  let alignment: Alignment
//  let content: AttributedString
//
//  public init(
//    _ title: String? = nil,
//    separator: String = "\n",
//    alignment: Alignment = .center,
//    @DisplayStringBuilder content: () -> [DisplayBlock]
//  ) {
//    self.title = title
//    self.alignment = alignment
//    self.content = content().styledOutput()
//  }
//
//  public var body: some View {
//    Text(textOutput)
////            .fixedSize()
//      .frameFromGridSize(width: gridWidth, height: gridHeight)
//      .gridSetup(.sfMono, fontSize: 20)
//
//      .environment(\.isShowingGridGuide, true)
//
//    //      .debugTextOverlay(
//    //        """
//    //        Width: \(gridWidth?.toString, default: "nil")
//    //        Text Content: \(content.toString)
//    //        """
//    //      ).disabled(true)
//
//  }
//}
//
//extension HeaderBoxView {
//  private var theme: Box.Theme {
//    Box.Theme(
//      glyphSet: glyphSet,
//      frameStyle: frameStyle,
//      padding: 1
//    )
//  }
//  private var textOutput: String {
//    Box(theme: theme) {
//      
//      Box.Top()
//      if let title {
//        Box.Header(title)
//        Box.Divider()
//      }
//      content.toString
//      Box.Bottom()
//      
//    }.plainText
//  }
//}
//
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//
//  VStack(spacing: 14) {
//
//    //    BoxTextView("I love boxes made of text") {
//    //      DummyContent.Strings.paragraphs[8].toAttributed
//    //    }
//    //    .setGridFrame(42)
//    GroupBox("Top Only") {
//      
//    }
//    
//    HeaderBoxView("Single, Rounded Frame Style") {
//      "Short text content"
//      "Felix and Isla are cool"
//    }
//    .setBoxStyle(
//      glyphs: .rounded,
//      frame: .single,
//      metrics: []
//    )
//
//    HeaderBoxView("Double Frame") {
//      "Some content here"
//    }
//    .setBoxStyle(
//      glyphs: .double,
//      frame: .double,
//      metrics: []
//    )
//
//    //    HeaderBoxView("Double Frame Style") {
//    //      "Hello, I'm some text content in this box."
//    //      "Isn't that great!"
//    //    }
//    //    .setBoxStyle(
//    //      glyphs: .double,
//    //      frame: .double(exterior: .increased, interior: .standard)
//    //    )
//    //    .setGridFrame(10)
//
//    //    BoxTextView {
//    //      "No header text"
//    //      "This is another line"
//    //    }
//    //    .setGridFrame(38)
//    //    .setBoxStyle(glyphs: .rounded, frame: .single())
//
//  }
//  .textSelection(.enabled)
//  .monospaced()
//  //  .environment(\._lineHeightMultiple, 0.84)
//  .frame(
//    minWidth: 400,
//    minHeight: 600
//  )
//  .background(.black.opacity(0.6))
//}
//#endif
