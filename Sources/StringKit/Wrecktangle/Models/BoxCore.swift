//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

/// An ASCII box without any text content, just the structure.
/// For wrapping a SwiftUI view in a box
public struct ViewBox {
  let width: Int
  let height: Int
  let theme: Box.Theme
}

public struct Box {
  var header: String?
  var content: AttributedString
  var config: Config
}

extension Box {

  public init(
    header: String?,
    content: AttributedString,
    width: Int,
    glyphSet: Box.GlyphSet,
    frameStyle: Box.Theme.FrameStyle,
    counterStyle: TextCore.WidthCounterStyle = .ruler
  ) {

    let theme = Box.Theme(
      glyphSet: glyphSet,
      frameStyle: frameStyle,
      padding: 1
    )

    let config = Box.Config(
      theme: theme,
      width: width,
      headerLineLimit: 2,
      contentLineLimit: 8,
      counterStyle: counterStyle
    )

    self.header = header
    self.content = content
    self.config = config
  }

  public var attributedString: AttributedString { drawBox() }
  public var plainText: String { attributedString.toString }

  public var theme: Theme { config.theme }
  public var glyphSet: GlyphSet { config.theme.glyphSet }
  public var boxWidth: Int { config.width }

}

extension Box: CustomStringConvertible {
  public var description: String { plainText }
}
