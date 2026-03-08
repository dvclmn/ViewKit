//
//  ViewportIndicatorModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import BasePrimitives
import SwiftUI

public struct ViewportSizeIndicatorModifier: ViewModifier {
  @Environment(\.viewportRect) private var viewportRect

  public func body(content: Content) -> some View {
    content
      .overlay {
        Canvas { context, size in
          context.debugEnvironmentViewportRect(in: size)
        }
        //        .ignoresSafeArea()
        .overlay {
          Text("Viewport Rect: \(viewportRect?.displayString(.concise), default: "None Found")")
            .font(.title)
            .background(.black.secondary)
        }
        .allowsHitTesting(false)
      }
  }
}

extension GraphicsContext {
  public func debugEnvironmentViewportRect(in size: CGSize) {

    guard let rect = environment.viewportRect else { return }

    if size != rect.size {
      print(
        """
        ⚠️ This Canvas view does not match the size of the full viewport; 
        result of this debug visual may be undefined.
        Canvas Size:    \(size.displayString)
        Viewport Size:  \(rect.size.displayString)
        Rect origin:    \(rect.origin.displayString)


        """
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
    self.modifier(ViewportSizeIndicatorModifier())
  }
}
