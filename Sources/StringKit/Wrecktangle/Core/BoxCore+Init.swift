//
//  Box+Init.swift
//  BoxCore
//
//  Created by Dave Coleman on 16/9/2024.
//

extension Box {

  public init(
    header: String,
    content: String,
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

//    let metrics: Box.Config.Metrics?
//    if let widthCounter {
//      metrics = Box.Config.Metrics(
//        widthCounter: widthCounter,
//        lineNumbers: false,
//        invisibles: false
//      )
//    } else {
//      metrics = nil
//    }

    let config = Box.Config(
      theme: theme,
      width: width,
      headerLineLimit: 2,
      contentLineLimit: 8,
      counterStyle: counterStyle
//      metrics: metrics
    )

    self.header = header
    self.content = content
    self.config = config

  }

}
