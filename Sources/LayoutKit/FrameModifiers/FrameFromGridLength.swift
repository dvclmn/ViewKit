//
//  FrameFromGridLength.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/1/2026.
//

import SwiftUI
import BasePrimitives

public struct FrameFromUnitLength: ViewModifier {
  @Environment(\.unitSize) private var unitSize
  @Environment(\.axisMapping) private var axisMapping
  
  let axis: Axis
  let length: Int
//  let convention: AxisConvention
  let alignment: Alignment
  
  public func body(content: Content) -> some View {
    content
      .frame(
        width: dimensions.width,
        height: dimensions.height,
        alignment: alignment
      )
  }
}
extension FrameFromUnitLength {
  
  private var dimensions: FrameDimensions {
    guard let unitSize else { return nil }
    
    let screenLength = length.toScreenLength(
      along: axis.toGridAxis,
      mapping: axisMapping,
      using: unitSize
    )

    return FrameDimensions(
      fromLength: screenLength,
      axis: axis.toAxisSet,
      alignment: alignment
    )
  }
}

extension View {
  
  public func frameFromUnitLength(
    axis: Axis = .horizontal,
    length: Int,
    alignment: Alignment = .center,
//    convention: AxisConvention = .default,
  ) -> some View {
    self.modifier(
      FrameFromUnitLength(
        axis: axis,
        length: length,
        alignment: alignment
      )
    )
  }

}
