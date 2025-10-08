//
//  FromFromRectModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 30/7/2025.
//

import BaseHelpers
import SwiftUI

// MARK: - Frame modifiers
public struct FrameFromRectModifier: ViewModifier {

  let rect: CGRect?
  let alignment: Alignment
  public func body(content: Content) -> some View {
    content
      .frame(
        width: rect?.width,
        height: rect?.height,
        alignment: alignment
      )
      .position(
        x: rect?.midX ?? .zero,
        y: rect?.midY ?? .zero
      )
  }
}

public struct FrameWithAspectRatioModifier: ViewModifier {
  
  let aspectRatio: CGFloat
  let contentMode: ContentMode
  public func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .aspectRatio(aspectRatio, contentMode: contentMode)
  }
}

public struct FrameFromSizeModifier: ViewModifier {

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

// MARK: - View extensions
extension View {

  public func frameFromRect(
    _ rect: CGRect?,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromRectModifier(
        rect: rect,
        alignment: alignment
      )
    )
  }

  public func frameFromLength(
    _ length: CGFloat,
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
  
  public func frameWithAspectRatio(
    _ ratio: CGFloat,
    contentMode: ContentMode = .fit
  ) -> some View {
    self.modifier(
      FrameWithAspectRatioModifier(
        aspectRatio: ratio,
        contentMode: contentMode
      )
    )
  }
}
