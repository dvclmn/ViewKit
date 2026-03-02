//
//  GridLineContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import SwiftUI

struct GridLineContext {
  let unitSize: CGSize
  let containerSize: CGSize
  let sizeMode: GridSizeMode
  let pinMode: GridPinMode
  let lineColour: Color
  let lineWidth: CGFloat
  let annotations: GridAnnotationDensity
  let drawsBorder: Bool
}
