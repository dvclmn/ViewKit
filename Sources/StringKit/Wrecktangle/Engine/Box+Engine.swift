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
  func textLine(_ content: String) -> Box.LineType {
    let textLine = Box.TextLine(
      leading: .vertical(.leading),
      text: content,
      trailing: .vertical(.trailing)
    )
    return Box.LineType.text(textLine)

  }

  func structureLine(
    type: Box.StructureType
  ) -> Box.LineType {

    let line =
      switch type {
        case .top: Box.LineType.structure(.top)
        case .divider: Box.LineType.structure(.divider)
        case .bottom: Box.LineType.structure(.bottom)
        case .blank: Box.LineType.structure(.blank)
      }

    return line
  }

  /// The remaning width for text, after removing space
  /// reserved for structural elements
  public var widthForText: Int {
    let capCount = config.theme.frameStyle.reservedDimensions.width
    let finalWidth = max(0, config.width - capCount)
    //    print("Width for text: \(finalWidth)")
    return finalWidth
  }

  public var heightForText: Int? {
    guard let height = config.height else { return nil }
    let capCount = config.theme.frameStyle.reservedDimensions.height
    return max(0, height - capCount)
  }
}

extension Array where Element == Box.LineType {
  func buildString(using engine: Box.Engine) -> String {
    let lines = self.map { line in
      line.buildString(using: engine)
    }
    return lines.joined(separator: "\n")
  }
}

extension Box.LineType {
  func buildString(
    using engine: Box.Engine
  ) -> String {
    switch self {
      case .text(let line):
        let textContent = TextReflow(
          line.text,
          width: engine.widthForText,
          paddingCharacter: " ",
          shouldHyphenate: true
        )
        let reflowed = textContent.reflowed(
          paddingH: engine.config.theme.padding.width
        )

        let leading = line.leading.buildStack(
          toWidth: engine.width,
          using: engine.theme
        ).string
        
        let trailing = line.trailing.buildStack(
          toWidth: engine.width,
          using: engine.theme
        ).string

        let result = reflowed.map { line in
          leading + line + trailing
        }.joined("\n")

        return result

      case .structure(let type):
        let parts = type.parts()
        
        let stacks = parts.map { part in
          part.buildStack(toWidth: engine.width, using: engine.theme)
        }
        return StringStack.joined(stacks, along: .horizontal).string

    }
  }
}
