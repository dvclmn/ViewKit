//
//  GridFontDescriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

public struct GridFontDescriptor {
  let style: GridFont
  let size: CGFloat
  
  public init(
    style: GridFont,
    size: CGFloat
  ) {
    self.style = style
    self.size = size
  }
}

extension GridFontDescriptor {
  public var font: Font {
    style.resolvedFont(size: size)
  }
}
