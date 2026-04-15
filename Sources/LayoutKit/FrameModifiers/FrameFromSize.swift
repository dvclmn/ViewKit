//
//  FrameFromSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/10/2025.
//

import BasePrimitives
import SwiftUI

public struct FrameFromSizeModifier: ViewModifier {

  let dimensions: FrameDimensions
  public func body(content: Content) -> some View {
    content
      .frame(
        width: dimensions.width,
        height: dimensions.height,
        alignment: dimensions.alignment,
      )
  }
}

extension View {

  /// Specify both H and V axes to form a square.
  public func frameFromLength<T: BinaryFloatingPoint>(
    _ length: T?,
    axis: Axis.Set,
    alignment: Alignment = .center,
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(
        dimensions: FrameDimensions(
          fromLength: length?.toCGFloat,
          axis: axis,
          alignment: alignment,
        )
      )
    )
  }

  /// Sets a frame with same value for width and height
  public func frameFromSquare<T: BinaryFloatingPoint>(
    _ length: T?,
    alignment: Alignment = .center,
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(
        dimensions: FrameDimensions(
          fromLength: length?.toCGFloat,
          axis: [.horizontal, .vertical],
          alignment: alignment,
        )
      )
    )
  }

  public func frameFromSize(
    _ size: CGSize?,
    alignment: Alignment = .center,
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(
        dimensions: FrameDimensions(fromSize: size, alignment: alignment)
      )
    )
  }

  public func frameFromDimensions(
    _ dimensions: FrameDimensions
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(dimensions: dimensions)
    )
  }

}
