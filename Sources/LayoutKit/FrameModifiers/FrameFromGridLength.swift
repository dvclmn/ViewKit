//
//  FrameFromGridLength.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/1/2026.
//

import SwiftUI
import SharedHelpers

public struct FrameFromGridLength: ViewModifier {
  @Environment(\.unitSize) private var unitSize
  
  let axis: Axis
  let length: Int
  let convention: AxisConvention
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
extension FrameFromGridLength {
  
  private var dimensions: FrameDimensions {
    guard let unitSize else { return nil }
    
    let screenLength = length.toScreenLength(
      along: axis.toAxis2D,
      convention: convention,
      using: unitSize
    )
    //    let unitLength = axis.toAxis2D
    //    let unitLength = axis.length(fromSize: unitSize)
//    guard let length = length.toScreenLength(using: unitLength) else { return nil }
    
    return FrameDimensions(
      fromLength: screenLength,
      axis: axis.toAxisSet,
      alignment: alignment
    )
  }
}

extension View {
  
  public func frameFromGridLength(
    axis: Axis = .horizontal,
    length: Int,
    alignment: Alignment = .center,
    convention: AxisConvention = .default,
  ) -> some View {
    self.modifier(
      FrameFromGridLength(
        axis: axis,
        length: length,
        convention: convention,
        alignment: alignment
      )
    )
  }

}
