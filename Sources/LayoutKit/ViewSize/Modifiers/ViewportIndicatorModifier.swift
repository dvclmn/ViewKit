//
//  ViewportIndicatorModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import SwiftUI

public struct ViewportSizeIndicatorModifier: ViewModifier {
  @Environment(\.viewportRect) private var viewportRect

  let isEnabled: Bool
  public func body(content: Content) -> some View {
    content
      .background {

        if isEnabled {
          if let viewportSize = viewportRect?.size {
            Rectangle()
              .fill(.brown.opacity(0.2))
              .stroke(.orange.opacity(0.5), lineWidth: 1)
              .frame(width: viewportSize.width, height: viewportSize.height)
          } else {
            Circle()
              .fill(.red.tertiary)
          }
        }
      }
      .background {
        if isEnabled {
          if let viewportRect {
            Rectangle()
              .fill(.cyan.opacity(0.2))
              .stroke(.purple.opacity(0.7), lineWidth: 1)
              .frame(width: viewportRect.width, height: viewportRect.height)
              .offset(x: viewportRect.origin.x, y: viewportRect.origin.y)
          } else {
            Circle()
              .fill(.mint.tertiary)
          }
        }
      }

    //      .overlay(alignment: .topLeading) {
    //        if let viewportRect {
    //          Rectangle()
    //            .fill(.brown.tertiary)
    //            .stroke(.orange.secondary, lineWidth: 1)
    //            .frame(
    //              width: viewportRect.width,
    //              height: viewportRect.height,
    //              alignment: .topLeading
    //            )
    //            .offset(
    //              x: viewportRect.origin.x,
    //              y: viewportRect.origin.y
    //            )
    //            .allowsHitTesting(false)
    //        }
    //      }
  }
}
