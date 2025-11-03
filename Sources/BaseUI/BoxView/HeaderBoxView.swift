//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import LayoutKit
import StringShared
import SwiftUI

public struct HeaderBoxView: View {
  @Environment(\.glyphSet) private var glyphSet
  @Environment(\.frameStyle) private var frameStyle
  @Environment(\.gridWidth) private var gridWidth
  @Environment(\.gridHeight) private var gridHeight

  @State private var characterSize: CGSize?

  let title: String?
  let alignment: Alignment
  let content: AttributedString

  public init(
    _ title: String? = nil,
    separator: String = "\n",
    alignment: Alignment = .center,
    @DisplayStringBuilder content: () -> [DisplayBlock]
  ) {
    self.title = title
    self.alignment = alignment
    self.content = content().styledOutput()
  }

  public var body: some View {
    Text(textOutput)

      .frameFromGridSize(width: gridWidth, height: gridHeight)
      .gridSetup(.sfMono, fontSize: 28)

      .environment(\.isShowingGridGuide, true)

      .debugTextOverlay(
        """
        Width: \(gridWidth?.toString, default: "nil")
        Text Content: \(content.toString)
        """
      ).disabled(true)

  }
}

extension HeaderBoxView {
  private var textOutput: AttributedString {
    Box {
      Box.Header("Some text")
    }.plainText
//    HeaderBox(
//      header: title ?? "Header",
//      content: content,
//      width: gridWidth ?? 10,
//      glyphSet: glyphSet,
//      frameStyle: frameStyle
//    ).attributedString
  }
}


#if DEBUG
#Preview(traits: .size(.normal)) {
  
  VStack(spacing: 14) {
    
    //    BoxTextView("I love boxes made of text") {
    //      DummyContent.Strings.paragraphs[8].toAttributed
    //    }
    //    .setGridFrame(42)
    
    HeaderBoxView("Single Frame Style") {
      "Short text content"
    }
    .setBoxStyle(
      glyphs: .double,
      frame: .single(frame: .increased, dividers: .standard)
    )

    HeaderBoxView("Double Frame Style") {
      "Hello, I'm some text content in this box."
      "Isn't that great!"
    }
    .setBoxStyle(
      glyphs: .double,
      frame: .double(exterior: .increased, interior: .standard)
    )
//    .setGridFrame(10)
    
    //    BoxTextView {
    //      "No header text"
    //      "This is another line"
    //    }
    //    .setGridFrame(38)
    //    .setBoxStyle(glyphs: .rounded, frame: .single())
    
  }
  .textSelection(.enabled)
  .monospaced()
  //  .environment(\._lineHeightMultiple, 0.84)
  .frame(
    minWidth: 400,
    minHeight: 600
  )
  .background(.black.opacity(0.6))
}
#endif
