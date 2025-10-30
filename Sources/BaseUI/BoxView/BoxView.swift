//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import LayoutKit
import StringShared
import SwiftUI

public struct BoxView: View {
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
      .characterSize(mode: .debounce(0.2)) { size in
        updateIfChanged(&self.characterSize, to: size)
      }
      .gridFrame(gridWidth, gridHeight)
      .environment(\.unitSize, characterSize)

      .overlay {
        GridGuideOverlay(opacity: 0.1)
          .isDebugMode(true)
      }
  }
}

extension BoxView {
  private var textOutput: AttributedString {
    Box(
      header: title,
      content: content,
      width: gridWidth ?? 20,
      glyphSet: glyphSet ?? .sharp,
      frameStyle: frameStyle ?? .single,
      counterStyle: .ruler
    ).attributedString
  }
}
