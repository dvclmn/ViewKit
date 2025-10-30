//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

//public typealias Box = BoxCore

public struct Box {

  var header: String?
  var content: String
  var config: Config

  public var attributedString: AttributedString {
    return self.drawBox()
  }

  public init(
    header: String? = nil,
    content: String,
    config: Config = .init()
  ) {
    self.header = header
    self.content = content
    self.config = config
  }
}

extension Box {

  public var theme: Theme { config.theme }
  public var glyphSet: GlyphSet { config.theme.glyphSet }
  public var boxWidth: Int { config.width }

  /// The remaning width for text, after removing space
  /// reserved for structural elements
  public var widthForText: Int {
    let caps = theme.frameStyle.maximumGridSize.width.value

    return max(0, boxWidth - caps)

  }

  //  var shadow: BoxCore.Theme.Shadow {
  //    self.config.theme.shadow
  //  }
  //
  //  var shadowCharacter: Character {
  //    self.config.theme.shadow.strength.character
  //  }

}

extension Box: CustomStringConvertible {
  public var description: String {
    self.attributedString.toString
  }
}
