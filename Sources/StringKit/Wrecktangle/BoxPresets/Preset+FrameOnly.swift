//
//  ViewBox.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import Foundation

//public protocol BoxShape {
//  
//  func drawBox() -> AttributedString
//}

/// Note: This and the OG `Box` can probably just be seen as
/// different Configs, or arrangements of Box primitives (Lines, Parts, etc).
/// These don't need to really know about how to build these parts,
/// should probably be dumb, and be driven by a Box Engine.

/// An ASCII box without any text content, just the structure.
/// For wrapping a SwiftUI view in a box
public struct FrameBox {
  let width: Int
  let height: Int
  let theme: Box.Theme

  public init(
    width: Int,
    height: Int,
    theme: Box.Theme = .default
  ) {
    self.width = width
    self.height = height
    self.theme = theme
  }
}

extension FrameBox {
  
  public var attributedString: AttributedString { drawBox() }
  public var plainText: String { attributedString.toString }
  
  func drawBox() -> AttributedString {
    
    let builder = Box.Builder(
      width: width,
      height: nil,
      theme: theme
    )
    
    let top = builder.structureLine(type: .top)
//    let header = builder.textLine(content: header)
    let divider = builder.structureLine(type: .divider())
    let content = builder.structureLine(type: .divider("?"))
    let bottom = builder.structureLine(type: .bottom)
    
    let result = Box.Line.joinLines(
      lines: top, divider, content, bottom,
      with: theme
    )
    
    return AttributedString(result.string)
    
    //    let theme = config.theme
    
    //    let top = Box.Line.
    
    //    let top = Box.Line.structureLine(.horizontal(.top), theme: theme, width: config.width)
    //    let header = Box.Line.textLine(box.header ?? "", theme: theme, totalWidth: config.width)
    //    let separator = Box.Line.structureLine(.horizontal(.middle), theme: theme, width: config.width)
    //    let content = Box.Line.textLine(box.content.characters, theme: theme, totalWidth: config.width)
    //    let bottom = Box.Line.structureLine(.horizontal(.bottom), theme: theme, width: config.width)
    //
    //    return StringStack.joinVertically([
    //      top.render(toTotalWidth: config.width),
    //      header.render(toTotalWidth: config.width),
    //      separator.render(toTotalWidth: config.width),
    //      content.render(toTotalWidth: config.width),
    //      bottom.render(toTotalWidth: config.width),
    //    ])
  }
}
//
//extension ViewBox {
//
//  public var attributedString: AttributedString { drawBox() }
//  public var plainText: String { attributedString.toString }
//
//  func drawBox() -> AttributedString {
//
//    let builder = Box.Builder(
//      width: width,
//      height: height,
//      theme: theme
//    )
//
//    /// We start off with a fresh, blank attr. string. The 'build process' is based
//    /// on concatenation, added section-by-section, starting from the top.
//    var output = AttributedString()
//
//    /// Box roof
//    let top = builder.buildLine(.structure(.top))
//    output.append(top, addsLineBreak: true)
//
//    /// Content
//    let adjustedHeight = builder.heightForText ?? height
//    for _ in 0..<adjustedHeight {
//      let blank = builder.buildLine(.blank)
//      output.append(blank, addsLineBreak: true)
//    }
//
//    /// Bottom
//    let bottom = builder.buildLine(.structure(.bottom))
//    output.append(bottom, addsLineBreak: true)
//
//    return output
//  }
//}
