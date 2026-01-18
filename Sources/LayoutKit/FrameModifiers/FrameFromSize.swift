//
//  FrameFromSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/10/2025.
//

import SwiftUI
import BasePrimitives

public struct FrameFromSizeModifier: ViewModifier {
  
//  let axis: Axis.Set?
//  let size: CGSize?
//  let width: CGFloat?
//  let height: CGFloat?
//  let alignment: Alignment
  
  let dimensions: FrameDimensions
  
  public func body(content: Content) -> some View {
    content
      .frame(
        width: dimensions.width,
        height: dimensions.height,
        alignment: dimensions.alignment
      )
  }
}
extension FrameFromSizeModifier {
//  private var dimensions: FrameDimensions {
//    if let axis {
//
//      return FrameDimensions(
//        fromLength: <#T##CGFloat#>,
//        axis: <#T##Axis#>,
//        alignment: <#T##Alignment#>
//      )
//      
//    } else {
//      return FrameDimensions(
//        width: width,
//        height: height,
//        alignment: alignment
//      )
//    }
//  }
}

extension View {
  
  /// Specify both H and V axes to form a square.
  public func frameFromLength(
    _ length: CGFloat?,
    axis: Axis.Set,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(
        dimensions: FrameDimensions(
          fromLength: length,
          axis: axis,
          alignment: alignment
        )
      )
    )
  }
  
  public func frameFromSize(
    _ size: CGSize?,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(
        dimensions: FrameDimensions(fromSize: size, alignment: alignment)
//        axis: nil,
//        size: size,
//        width: size?.width,
//        height: size?.height,
//        alignment: alignment
      )
    )
  }
  
  public func frameFromDimensions(
    _ dimensions: FrameDimensions
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(
        dimensions: dimensions
        //        axis: nil,
        //        size: size,
        //        width: size?.width,
        //        height: size?.height,
        //        alignment: alignment
      )
    )
  }
//  public func frameFromSize(
//    _ dimensions: FrameDimensions?,
//    alignment: Alignment = .center
//  ) -> some View {
//    self.modifier(
//      FrameFromSizeModifier(
//        dimensions: dimen
//      )
//    )
//  }
  
  
}
