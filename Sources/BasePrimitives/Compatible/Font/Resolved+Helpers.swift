//
//  Resolved+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

extension Font.ResolvedCompatible {

  
  //  public var style: Font.TextStyle {
  //    self.
  //  }
  
  public func toNSFont(
    _ style: Font.TextStyle,
    design: Font.Design? = nil,
    weight: Font.Weight? = nil
  ) -> NSFont {
    self.toCTFont(
      style,
      design: design,
      weight: weight
    )
  }
  
  /// Will fall back to the provided style/design/weight,
  /// if true resolved Font not available
  public func toCTFont(
    _ style: Font.TextStyle,
    design: Font.Design? = nil,
    weight: Font.Weight? = nil
  ) -> CTFont {
    
    //    let fallback = fallback ?? CTFont.init(.application, size: 14)
    guard #available(macOS 26, iOS 26, *) else {
      //      let nsFont = NSFont.preferredFont(forTextStyle: style.nsTextStyle)
      let nsFont = NSFont.preferredFont(for: style)
      
      //      let thing = self.fontResolved.ctFont.
      //      let desc = nsFont.fontDescriptor
      
      //      let thing = desc.
      //        style,
      ////        design: design,
      ////        weight: weight
      //      )
      return nsFont as CTFont
    }
    //      let thing = self.font.resolve(in: self.context)
    //      return thing.ctFont
    return fontResolved.ctFont
  }
  
}
