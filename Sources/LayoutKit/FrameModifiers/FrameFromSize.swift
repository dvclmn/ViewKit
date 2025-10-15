//
//  FrameFromSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/10/2025.
//

import SwiftUI

public struct FrameFromSizeModifier: ViewModifier {
  
  let axis: Axis.Set
  let width: CGFloat?
  let height: CGFloat?
  let alignment: Alignment
  
  public func body(content: Content) -> some View {
    content
      .frame(
        width: width,
        height: height,
        alignment: alignment
      )
  }
}
extension FrameFromSizeModifier {
  private var dimensions
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
        width: length,
        height: length,
        alignment: alignment
      )
    )
  }
  
  public func frameFromSize(
    _ size: CGSize?,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(
        width: size?.width,
        height: size?.height,
        alignment: alignment
      )
    )
  }
  public func frameFromSize(
    _ dimensions: FrameDimensions?,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromSizeModifier(
        width: dimensions?.width,
        height: dimensions?.height,
        alignment: alignment
      )
    )
  }
  
  
}
