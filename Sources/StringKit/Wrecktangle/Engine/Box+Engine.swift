//
//  BoxLine+Construct.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import Foundation

extension Box {
  public struct Engine: Codable, Sendable, Equatable {
    let config: Box.Config

    public init(_ config: Box.Config) {
      self.config = config
    }
  }
}

extension Box.Engine {
  var width: Int { config.width }

  var framePreset: Box.FramePreset { theme.frameStyle }
  var glyphDesign: Box.GlyphDesign { theme.glyphSet.design }

  var theme: Box.Theme { config.theme }
  var hasRowNumbers: Bool { config.metrics.contains(.lineNumbers) }

  func rowNumbers(for position: Box.PositionContext) -> String {
    guard hasRowNumbers else { return "" }
    return "\(position.rowNumber) "
  }

  func width(for component: LineComponent) -> Int {
    switch component {
      case .rowNumbers:
        return rowNumbersWidth

      case .repeatedPart:
        let reserved = capsWidth + rowNumbersWidth
        let result = width - reserved
        return max(0, result)

      case .text:
        let reserved = (theme.padding.width * 2) + capsWidth + rowNumbersWidth
        let widthForText = width - reserved
        return max(0, widthForText)

      case .lineCaps:
        return capsWidth

      case .fullLine:
        return self.width
    }
  }

  private var rowNumbersWidth: Int { hasRowNumbers ? 2 : 0 }
  private var capsWidth: Int { theme.frameStyle.frame.frameWidth(for: .leading).map { $0 * 2 } ?? 1 }

}

enum LineComponent {
  case rowNumbers
  case repeatedPart
  case text
  case lineCaps  // Includes *both* caps
  case fullLine
}
