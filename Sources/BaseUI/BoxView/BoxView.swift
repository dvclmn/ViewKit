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

  @State private var characterSize: CGSize?

  let width: Int
  let height: Int?
  let alignment: Alignment
  let content: AttributedString

  public init(
    separator: String = "\n",
    width: Int,
    height: Int? = nil,
    alignment: Alignment = .center,
    @DisplayStringBuilder content: () -> [DisplayBlock]
//    @TextBuilder content: () -> [Text]
  ) {
    self.width = width
    self.height = height
    self.alignment = alignment
    self.content = content().styledOutput()
//    self.content = content().joined(separator: Text(separator))
  }

  public var body: some View {
    Text(textOutput)
      .characterSize(mode: .debounce(0.2)) { size in
        updateIfChanged(&self.characterSize, to: size)
      }
      .frameFromGridSize(
        width: width,
        height: height,
        alignment: alignment
      )
    
      .environment(\.unitSize, characterSize)

      .overlay {
        GridGuideOverlay(opacity: 0.1)
      }
      .background(Color.mint.quaternary)
  }
}

extension BoxView {
  private var textOutput: AttributedString {
    Box(
      header: "No header just yet",
      content: content,
      width: width,
      glyphSet: glyphSet ?? .sharp,
      frameStyle: frameStyle ?? .single,
      counterStyle: .ruler
    ).attributedString
  }
}
