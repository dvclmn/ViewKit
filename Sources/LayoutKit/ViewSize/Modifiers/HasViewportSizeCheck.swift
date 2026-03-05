//
//  HasViewportSizeCheck.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import SwiftUI

public struct HasViewportSizeCheckModifier: ViewModifier {
  @Environment(\.viewportSize) private var viewportSize

  public func body(content: Content) -> some View {
    content
      .addDebugText(
        "No viewport size value in environment",
        isEnabled: viewportSize == nil
      )
    //      .backgroundTint(viewportSize == nil ? .red : .black)
  }
}

extension View {
  public func hasViewportSizeCheck() -> some View {
    self.modifier(HasViewportSizeCheckModifier())
  }
}

