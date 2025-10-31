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
  let padding: Int
  let content: Content

  public init(
    separator: String = "\n",
    padding: Int = 1,
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.alignment = alignment
    self.padding = padding
    self.content = content()
  }

  public var body: some View {
    content
      /// Padding to seat content within Box view
      .gridPadding(.horizontal, padding)
      .gridPadding(.vertical, padding * 2)

      .viewSize(mode: .debounce(0.2)) { size in
        updateIfChanged(&self.viewSize, to: size)
      }

      .gridFrame(
        dimensions?.width,
        dimensions?.height
      )
      .border(Color.orange.opacity(0.3))
      .background(.topLeading) {
        BoxFrame()
          .border(Color.green.opacity(0.3))
      }
      .overlay {
        GridGuideOverlay(opacity: 0.4)
          .isDebugMode(true)
          .border(Color.purple.opacity(0.3))
      }

  }
}

extension BoxView {

  @ViewBuilder
  private func BoxFrame() -> some View {
    if let w = dimensions?.width, let h = dimensions?.height {
      Text(
        ViewBox(
          width: w,
          height: h,
          theme: Box.Theme(
            glyphSet: glyphSet ?? .sharp,
            frameStyle: frameStyle ?? .single,
            padding: padding
          )
        ).attributedString
      )
      .fixedSize()
//      .frameFromGridSize(width: w, height: h, alignment: alignment)
    }
  }
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
