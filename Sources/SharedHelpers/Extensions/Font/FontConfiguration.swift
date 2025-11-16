//
//  Font.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import SwiftUI

//public struct FontConfiguration {
//  private let sizeOrStyle: FontSizeOrStyle
//  public let design: Font.Design
//  public let weight: Font.Weight
//
//  public init(
//    size: CGFloat,
//    design: Font.Design = .default,
//    weight: Font.Weight = .regular
//  ) {
//    self.sizeOrStyle = .size(size)
//    self.design = design
//    self.weight = weight
//  }
//
//  public init(
//    _ style: Font.TextStyle,
//    design: Font.Design = .default,
//    weight: Font.Weight = .regular
//  ) {
//    self.sizeOrStyle = .style(style)
//    self.design = design
//    self.weight = weight
//  }
//}
//
//extension FontConfiguration {
//  public var size: CGFloat? { self.sizeOrStyle.size }
//  public var style: Font.TextStyle? { self.sizeOrStyle.style }
//
//  public var nsFont: NSFont {
//    if let style = style {
//      return NSFont.preferredFont(style, design: design, weight: weight)
//      
//    } else if let size = size {
//      return NSFont.preferredFont(size: size, design: design, weight: weight)
//      
//    } else {
//      // Fallback to body style
//      return NSFont.preferredFont(.body, design: design, weight: weight)
//    }
//  }
//}
