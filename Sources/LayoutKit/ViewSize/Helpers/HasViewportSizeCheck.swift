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
      .debugTextOverlay(
        "No viewport size value in environment", isEnabled: viewportSize == nil, alignment: .topLeading
      )
      .backgroundTint(viewportSize == nil ? .red : .black)
  }
}

extension View {
  public func hasViewportSizeCheck() -> some View {
    self.modifier(HasViewportSizeCheckModifier())
  }
}

public struct ViewportSizeIndicatorModifier: ViewModifier {
  @Environment(\.viewportSize) private var viewportSize

  let isEnabled: Bool
  public func body(content: Content) -> some View {
    content
      .background {
        if let viewportSize {
          Rectangle()
            .fill(.cyan.opacity(0.2))
            .stroke(.blue.opacity(0.7), lineWidth: 1)
            .frame(width: viewportSize.width, height: viewportSize.height)
        } else {
          Circle()
            .fill(.red.tertiary)
        }
      }
  }
}
