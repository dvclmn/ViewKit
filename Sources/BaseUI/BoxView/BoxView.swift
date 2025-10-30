//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import LayoutKit
import StringShared
import SwiftUI

public struct BoxView<Content: View>: View {
  @Environment(\.glyphSet) private var glyphSet
  @Environment(\.frameStyle) private var frameStyle
  @Environment(\.gridWidth) private var gridWidth
  @Environment(\.gridHeight) private var gridHeight

  @State private var characterSize: CGSize?
  @State private var viewSize: CGSize?

  //  let title: String?
  let alignment: Alignment
  let content: Content

  public init(
    //    _ title: String? = nil,
    separator: String = "\n",
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content
      //    @DisplayStringBuilder content: () -> [DisplayBlock]
  ) {
    //    self.title = title
    self.alignment = alignment
    self.content = content()
  }

  public var body: some View {
    content
      //      .characterSize(mode: .debounce(0.2)) { size in
      //        updateIfChanged(&self.characterSize, to: size)
      //      }
      .characterAndViewSize(.debounce(0.2)) { char, view in
        updateIfChanged(&self.characterSize, to: char)
        updateIfChanged(&self.viewSize, to: view)
      }
      .gridFrame(
        viewSize?.toGridCount(
          along: <#T##Axis#>,
          using: <#T##CGSize#>,
          rounding: <#T##GridRounding#>
        ),
        gridHeight
      )
      .environment(\.unitSize, characterSize)

      .overlay {
        GridGuideOverlay(opacity: 0.1)
          .isDebugMode(true)
      }

      .background {
        Text(ViewBox(width: gridWidth ?? 20, height: gridHeight ?? 30, theme: .init()).attributedString)
      }
  }
}

extension BoxView {
  private var gridFame:
}

#if DEBUG
#Preview {

  VStack(spacing: 14) {

    BoxView("I love boxes made of text") {

      Text("I'm a SwiftUI View")
      Text(DummyContent.Strings.paragraphs[8].toAttributed)
    }
    //    .gridFrame(42)
    //    .boxStyle(glyphs: .double, frame: .double)

  }
  .textSelection(.enabled)
  .monospaced()
  .frame(
    minWidth: 400,
    minHeight: 600
  )
  .background(.black.opacity(0.6))
}
#endif
