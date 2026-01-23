//
//  ColourPair+Convenience.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit

extension ColourPair {

  /// Returns foreground only
  public var nsColour: NSColor? { nsColour(.fg) }

  public func nsColour(_ member: Self.PairType = .fg) -> NSColor? {
    switch member {
      case .fg: foreground.nsColor
      case .bg: background?.nsColor
    }
  }

  public var nsColourPair: (fore: NSColor, bg: NSColor)? {
    guard let fg = foreground.nsColor,
      let bg = background?.nsColor
    else { return nil }
    return (fg, bg)
  }

  /// Initialises a `ColourPair` from a single
  /// `NSColor`, passed to the `foreground`.
  /// Leaves background set to `nil` as default
  @available(*, deprecated, message: "This is possibly not working")
  public init?(
    fromNSColor foreground: NSColor,
    background: NSColor? = nil
  ) {
    guard let fg = foreground.usingColorSpace(.deviceRGB) else { return nil }
    let bg = background?.usingColorSpace(.deviceRGB)

    let fgRGB = CodableColour.rgbRaw(
      r: fg.redComponent,
      g: fg.greenComponent,
      b: fg.blueComponent
    )
    let bgRGB: CodableColour? = bg.map {
      CodableColour.rgbRaw(
        r: $0.redComponent,
        g: $0.greenComponent,
        b: $0.blueComponent
      )
    }
    self.init(fgRGB, background: bgRGB)
  }
}

extension ColourPair {
  public enum PairType {
    case fg
    case bg
  }
}
