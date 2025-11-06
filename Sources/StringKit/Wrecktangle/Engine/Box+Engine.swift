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
  var theme: Box.Theme { config.theme }
  var hasRowNumbers: Bool { config.metrics.contains(.lineNumbers) }

  private var capsWidth: Int { theme.frameStyle.reservedWidth * 2 }
  private var rowNumbersWidth: Int { hasRowNumbers ? 2 : 0 }

  var repeatedPartWidth: Int {
    let reserved = capsWidth + rowNumbersWidth
    let result = width - reserved
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
    let reservedWidth = (theme.padding.width * 2) + capsWidth + rowNumbersWidth
    let widthForText = width - reservedWidth
    return max(0, widthForText)
  }
}
