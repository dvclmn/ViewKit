//
//  BoxLine+Construct.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import Foundation

extension Box {

  public struct Engine: Codable, Sendable {
    let config: Box.Config

    public init(_ config: Box.Config) {
      self.config = config
    }

    public init(
      width: Int,
      height: Int?,
      theme: Box.Theme,
    ) {
      self.config = Config(w: width, h: height, theme: theme)
    }
  }
}

extension Box.Engine {
  var width: Int { config.width }
  var theme: Box.Theme { config.theme }
}

extension Box.Engine {

  /// This is used by the Builder's `Box.Component`
  /// This is meant to be the full, unreflowed text
  ///
  /// Note: The order of the parts here does not matter,
  /// this is handled later.
//  func textLine(_ content: String) -> Box.LineType {
//    let textLine = Box.TextLine(
//      text: content,
//      leading: .vertical(.leading),
//      trailing: .vertical(.trailing)
//    )
//    return Box.LineType.text(textLine)
//  }
//
//  func structureLine(
//    type: Box.StructureType
//  ) -> Box.LineType {
//    switch type {
//      case .top: Box.LineType.structure(.top)
//      case .divider: Box.LineType.structure(.divider)
//      case .bottom: Box.LineType.structure(.bottom)
//      case .blank: Box.LineType.structure(.blank)
//    }
//  }

  var widthForPartRepetition: Int {
    let reservedWidth = theme.frameStyle.reservedWidth * 2
    let result = width - reservedWidth
    return max(0, result)
  }

  /// The remaning width for text, after removing space
  /// reserved for structural elements
  ///
  /// ⚠️ IMPORTANT: TextReflow previously handled padding on
  /// either side of each reflow line of Text, however this
  /// responsibility has moved out of there, and back to the Box domain.
  ///
  /// That means it's important that we *do* remove padding from here,
  /// so that the width for text is accurate.
  var widthForText: Int {
    let padding = theme.padding.width
    let capWidths = theme.frameStyle.reservedWidth * 2
    let reservedWidth = (padding * 2) + capWidths

    let widthForText = width - reservedWidth
    return max(0, widthForText)
  }
}
