//
//  FrameFromAspectRatio.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/10/2025.
//

import SwiftUI

public struct FrameWithAspectRatioModifier: ViewModifier {

  let aspectRatio: CGFloat
  let contentMode: ContentMode
  public func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .aspectRatio(aspectRatio, contentMode: contentMode)
  }
}

extension View {
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
