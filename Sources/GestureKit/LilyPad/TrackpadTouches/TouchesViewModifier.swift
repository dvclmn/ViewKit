//
//  TouchesView.swift
//  LilyPad
//
//  Created by Dave Coleman on 7/5/2025.
//

import CoreTools
import SwiftUI

public struct TrackpadTouchesModifier: ViewModifier {
  @State private var localTouches: Set<TouchPoint> = []

  let isEnabled: Bool
  let mapStrategy: ContentSizeMode
  let shouldShowIndicators: Bool
  let didUpdateTouches: TouchesUpdate
  let didUpdatePressure: PressureUpdate

  public func body(content: Content) -> some View {
    GeometryReader { proxy in
      content
      if isEnabled && shouldShowIndicators {
        TouchIndicatorsView(
          mappedTouches: localTouches.toArray,
          mappingStrategy: mapStrategy,
          containerSize: proxy.size,
        )
      }
      TrackpadTouchesView(isDrawingEnabled: isEnabled) { touchOutput in
//        if isEnabled {
          if shouldShowIndicators {
            self.localTouches = touchOutput
          }
          didUpdateTouches(touchOutput)
//        }
      } didUpdatePressure: { pressure in
        didUpdatePressure(pressure)
      }

      //        .background(.cyan.opacity(0.1))
      //        .debugTextOverlay("No viewport size", isEnabled: viewportSize == nil)
      //      }  // END isEnabled check
    }  // END geo reader
  }
}
extension View {

  public func touches(
    isEnabled: Bool = true,
    mapStrategy: ContentSizeMode,
    showIndicators: Bool = true,
    didUpdateTouches: @escaping TouchesUpdate,
    didUpdatePressure: @escaping PressureUpdate = { _ in }
  ) -> some View {
    self.modifier(
      TrackpadTouchesModifier(
        isEnabled: isEnabled,
        mapStrategy: mapStrategy,
        shouldShowIndicators: showIndicators,
        didUpdateTouches: didUpdateTouches,
        didUpdatePressure: didUpdatePressure,
      )
    )
  }
}
