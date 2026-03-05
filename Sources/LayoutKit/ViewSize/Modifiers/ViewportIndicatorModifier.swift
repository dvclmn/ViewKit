//
//  ViewportIndicatorModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import SwiftUI
import CoreTools


public struct ViewportSizeIndicatorModifier: ViewModifier {
  @Environment(\.viewportRect) private var viewportRect

  let isEnabled: Bool
  public func body(content: Content) -> some View {
    content
    
      .overlay {

        Canvas { context, size in
          context.debugEnvironmentViewportRect(in: size)
        }
//        if isEnabled {
//          if let viewportSize = viewportRect?.size {
//            Rectangle()
//              .fill(.brown.opacity(0.2))
//              .stroke(.orange.opacity(0.5), lineWidth: 1)
//              .frame(width: viewportSize.width, height: viewportSize.height)
//          } else {
//            Circle()
//              .fill(.red.tertiary)
//          }
//        }
//      }
//      .overlay {
//        if isEnabled {
//          if let viewportRect {
//            Rectangle()
//              .fill(.cyan.opacity(0.2))
//              .stroke(.purple.opacity(0.7), lineWidth: 1)
//              .frame(width: viewportRect.width, height: viewportRect.height)
//              .offset(x: viewportRect.origin.x, y: viewportRect.origin.y)
//          } else {
//            Circle()
//              .fill(.mint.tertiary)
//              Text("No viewportRect found in Env")
//          }
//        }
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
