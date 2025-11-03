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

      .gridSetup(.sfMono, fontSize: 28)
    
      .environment(\.isShowingGridGuide, true)
      .frameFromGridSize(width: gridWidth, height: gridHeight)
      .setGridFrame(gridWidth, gridHeight)
    
      .debugTextOverlay(
        """
        Width: \(gridWidth?.toString, default: "nil")
        """)

  }
}

extension HeaderBoxView {
  private var textOutput: AttributedString {
    HeaderBox(
      header: title ?? "Header",
      content: content,
      width: gridWidth ?? 10,
      glyphSet: glyphSet,
      frameStyle: frameStyle
    ).attributedString
  }
}

#if DEBUG
#Preview {

  VStack(spacing: 14) {

    //    BoxTextView("I love boxes made of text") {
    //      DummyContent.Strings.paragraphs[8].toAttributed
    //    }
    //    .setGridFrame(42)

    HeaderBoxView("Header title") {
      "Hello"
    }
    .setGridFrame(10)
    .setBoxStyle(glyphs: .double, frame: .double(exterior: .increased, interior: .standard))

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
  //  .frame(width: 370, height: 640)
  .background(.black.opacity(0.6))
}
#endif
