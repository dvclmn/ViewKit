//
//  DrawMarqueeModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 13/7/2025.
//

import SwiftUI

public struct DrawMarqueeModifier: ViewModifier {
  let rect: CGRect?
  
  public func body(content: Content) -> some View {
    content
      .overlay {
        if let rect {
          ZStack {
            Canvas { context, size in
              context.stroke(rect.path, with: .color(.pink))
            }
            .allowsHitTesting(false)

            //            Text("Origin: \(rect.origin.displayString(places: 0))")
            //              .font(.caption)
            //              .quickBackground()
          }

        }  // END rect check, is enabled
      }  // END overlay
  }
}

extension View {
  public func drawMarqueeRect(
    rect: CGRect?,
    isEnabled: Bool
  ) -> some View {
    self.modifier(DrawMarqueeModifier(rect: rect))
  }
}
