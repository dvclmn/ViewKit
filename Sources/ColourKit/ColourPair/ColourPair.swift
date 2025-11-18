//
//  ColourPair.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

public struct ColourPair: Sendable, Codable, Hashable {
  public let foreground: CodableColour
  public let background: CodableColour?

  public init(
    foreground: CodableColour,
    background: CodableColour? = nil
  ) {
    self.foreground = foreground
    self.background = background
  }

  public init(
    _ foreground: CodableColour,
    background: CodableColour? = nil
  ) {
    self.init(
      foreground: foreground,
      background: background
    )
  }
}
