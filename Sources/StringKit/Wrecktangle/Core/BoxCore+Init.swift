//
//  Box+Init.swift
//  BoxCore
//
//  Created by Dave Coleman on 16/9/2024.
//

public extension Box {
  
  init(
    header: String,
    content: String,
    width: Int,
    glyphSet: Box.GlyphSet,
    frameStyle: Box.Theme.FrameStyle,
    widthCounter: TextCore.WidthCounterStyle
  ) {
    let theme = Box.Theme(
      glyphSet: glyphSet,
      frameStyle: frameStyle,
      padding: 1
    )
    
    let metrics = Box.Config.Metrics(
      widthCounter: widthCounter,
      lineNumbers: false,
      invisibles: false
    )
    
    let config = Box.Config(
      theme: theme,
      width: width,
      headerLineLimit: 2,
      contentLineLimit: 8,
      wordWrapStrategy: .hyphenate,
      metrics: metrics
    )
    
    self.header = header
    self.content = content
    self.config = config
    
    
  }

}
