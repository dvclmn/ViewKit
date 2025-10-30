//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

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

  /// The remaning width for text, after removing space
  /// reserved for structural elements
  public var widthForText: Int {
    let capCount = theme.frameStyle.maximumGridSize.width.value
    return max(0, boxWidth - capCount)
  }
}

extension Box: CustomStringConvertible {
  public var description: String { plainText }
}
