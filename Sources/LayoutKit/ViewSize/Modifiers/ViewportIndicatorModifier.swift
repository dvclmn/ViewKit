//
//  ViewportIndicatorModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import CoreTools
import SwiftUI

public struct ViewportSizeIndicatorModifier: ViewModifier {
  @Environment(\.viewportRect) private var viewportRect

  let isEnabled: Bool
  public func body(content: Content) -> some View {
    content

      .overlay {

        Canvas { context, size in
          context.debugEnvironmentViewportRect(in: size)
        }
        .allowsHitTesting(false)
      }
  }
}

extension GraphicsContext {
  public func debugEnvironmentViewportRect(
    in size: CGSize,
    //    colour: Color = .gray,
    //    strokeStyle: StrokeStyle? = nil,
    //    strokeWidth: CGFloat = 2
  ) {

    guard let rect = environment.viewportRect else { return }

    if size != rect.size {
      print(
        "⚠️ This Canvas view does not match the size of the full viewport; result of this debug visual may be undefined. Canvas Size: \(size), Viewport Rect: \(rect)"
      )
    }

    let fullBleedRect = CGRect(fromSize: size)

    fillAndStroke(
      Path(fullBleedRect),
      fillColour: .brown.opacity(0.25),
      strokeColour: .orange,
    )

    fillAndStroke(
      Path(rect),
      fillColour: .purple.opacity(0.25),
      strokeColour: .purple,
    )
  }
}

extension View {
  public func viewportRectIndicator() -> some View {
    self.modifier(ViewportSizeIndicatorModifier(isEnabled: true))
  }
}
