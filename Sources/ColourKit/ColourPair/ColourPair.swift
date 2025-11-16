//
//  ColourPair.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

public struct ColourPair: Sendable, Codable, Hashable {
  let foreground: CodableColour
  let background: CodableColour?
  
  public init(
    foreground: CodableColour,
    background: CodableColour? = nil
  ) {
    self.foreground = foreground
    self.background = background
  }
  
  public init(
    _ foreground: CodableColour,
    _ background: CodableColour? = nil
  ) {
    self.init(
      foreground: foreground,
      background: background
    )
  }
  
}
