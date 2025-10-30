//
//  ViewBox.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import Foundation

/// An ASCII box without any text content, just the structure.
/// For wrapping a SwiftUI view in a box
public struct ViewBox {
  let width: Int
  let height: Int
  let theme: Box.Theme
  
  public init(
    width: Int,
    height: Int,
    theme: Box.Theme = .init()
  ) {
    self.width = width
    self.height = height
    self.theme = theme
  }
}

extension ViewBox {
  
  public var attributedString: AttributedString { drawBox() }
  public var plainText: String { attributedString.toString }

  func drawBox() -> AttributedString {

    let builder = Box.Builder(
      width: width,
      theme: theme
    )

    /// We start off with a fresh, blank attr. string. The 'build process' is based
    /// on concatenation, added section-by-section, starting from the top.
    var output = AttributedString()

    /// Box roof
    let top = builder.buildLine(.structure(.top))
    output.append(top, addsLineBreak: true)

    /// Content
    for _ in 0..<(height - 2) {
      let blank = builder.buildLine(.structure(.blank))
      output.append(blank, addsLineBreak: true)
    }

    /// Bottom
    let bottom = builder.buildLine(.structure(.bottom))
    output.append(bottom, addsLineBreak: true)

    return output
  }

}
