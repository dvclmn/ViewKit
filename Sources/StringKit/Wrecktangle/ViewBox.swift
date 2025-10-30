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
}

extension ViewBox {
  
  func drawBox() -> AttributedString {
    
    let builder = Box.Builder(
      width: width,
      theme: theme
    )
    
    /// We start off with a fresh, blank attr. string. The 'build process' is based
    /// on concatenation, added section-by-section, starting from the top.
    var output = AttributedString()

    /// Box roof
    let top = builder.buildLine(.top)
    output.append(top, addsLineBreak: true)
    
    /// Header
//    if let headerText = self.header {
//      buildHeader(headerText, builder, output: &output)
//    }
    
    /// Content
//    buildContent(builder, output: &output)
    
    /// Bottom
    let bottom = builder.buildLine(.bottom)
    output.append(bottom, addsLineBreak: true)
    
    return output
  }

}
