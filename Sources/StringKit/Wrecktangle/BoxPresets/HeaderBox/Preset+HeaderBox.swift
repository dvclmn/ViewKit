//
//  BoxHandler.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import SwiftUI

public struct HeaderBox {
  var header: String
  var content: String
//  var content: AttributedString
  var theme: Box.Theme
  var width: Int
  
  /// Need to figure this out
//  func paddingCharacter(for element: Box.Invisibles) -> Character {
//    config.metrics.contains(.invisibles) ? element.character : " "
//  }

  public init(
    header: String,
    content: String,
//    content: AttributedString,
    width: Int,
    glyphSet: Box.GlyphSet,
    frameStyle: Box.FrameStyle,
  ) {

    let theme = Box.Theme(
      glyphSet: glyphSet,
      frameStyle: frameStyle,
      padding: 1
    )

    self.header = header
    self.content = content
    self.theme = theme
//    self.config = config
    self.width = width
  }

//  public var attributedString: AttributedString { drawBox() }
  public var plainText: String { drawBox() }
//  public var plainText: String { attributedString.toString }

//  public var theme: Box.Theme { config.theme }
//  public var glyphSet: Box.GlyphSet { config.theme.glyphSet }
//  public var boxWidth: Int { config.width }

}
