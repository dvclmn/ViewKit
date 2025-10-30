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
  @Environment(\.unitSize) private var unitSize

  @State private var viewSize: CGSize?

  let alignment: Alignment
  let content: Content

  public init(
    separator: String = "\n",
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.alignment = alignment
    self.content = content()
  }

  public var body: some View {
    content
      .viewSize(mode: .debounce(0.2)) { size in
        updateIfChanged(&self.viewSize, to: size)
      }
      //      .viewSize(.debounce(0.2)) { size in
      //        updateIfChanged(&self.characterSize, to: char)
      //      }
      //      .characterAndViewSize(.debounce(0.2)) { char, view in
      //        updateIfChanged(&self.characterSize, to: char)
      //        updateIfChanged(&self.viewSize, to: view)
      //      }
      .gridFrame(
        dimensions?.width,
        dimensions?.height
      )

      .overlay {
        GridGuideOverlay(opacity: 0.1)
          .isDebugMode(true)
      }

      .background {
        Text(ViewBox(width: dimensions?.width ?? 20, height: dimensions?.height ?? 30, theme: .init()).attributedString)
      }
  }
}

extension BoxView {
  private var dimensions: GridDimensions? {
    guard let unitSize else { return nil }
    return viewSize?.toGridDimensions(using: unitSize, rounding: .down)
  }
}

#if DEBUG
#Preview {

  VStack(spacing: 14) {

    BoxView {

      Text("I'm a SwiftUI View")
      Text(DummyContent.Strings.paragraphs[8].toAttributed)
    }
    //        .gridFrame(42)
    //        .boxStyle(glyphs: .double, frame: .double)

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
