//
//  BoxHandler.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import SwiftUI

public struct HeaderBox {
  var header: String
  var content: AttributedString
  var theme: Box.Theme
  var width: Int
//  var config: Box.Config
  
//  func paddingCharacter(for element: Box.Invisibles) -> Character {
//    config.metrics.contains(.invisibles) ? element.character : " "
//  }

  public init(
    header: String,
    content: AttributedString,
    width: Int,
    glyphSet: Box.GlyphSet,
    frameStyle: Box.FrameStyle,
//    counterStyle: TextCore.WidthCounterStyle = .ruler
  ) {

    let theme = Box.Theme(
      glyphSet: glyphSet,
      frameStyle: frameStyle,
      padding: 1
    )

//    let config = Box.Config(
//      theme: theme,
//      width: width,
//      headerLineLimit: 2,
//      contentLineLimit: 8,
//      counterStyle: counterStyle
//    )

    self.header = header
    self.content = content
    self.theme = theme
//    self.config = config
    self.width = width
  }

  public var attributedString: AttributedString { drawBox() }
  public var plainText: String { attributedString.toString }

//  public var theme: Box.Theme { config.theme }
//  public var glyphSet: Box.GlyphSet { config.theme.glyphSet }
//  public var boxWidth: Int { config.width }

}
