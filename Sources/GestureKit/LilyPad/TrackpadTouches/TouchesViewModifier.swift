//
//  TouchesView.swift
//  LilyPad
//
//  Created by Dave Coleman on 7/5/2025.
//

import CoreTools
import SwiftUI

public struct TrackpadTouchesModifier: ViewModifier {
  @Environment(\.viewportSize) private var viewportSize
  @State private var localMappedTouches: Set<TouchPoint> = []

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
          mappedTouches: localMappedTouches.toArray,
          mappingStrategy: mapStrategy,
          containerSize: proxy.size,
        )
      }
      if isEnabled {
        TrackpadTouchesView() { touchOutput in

          if shouldShowIndicators {
            //            let touches = eventData?.touches ?? []
            /// Handle touches for local views
//            let mappedTouchBuilder = MappedTouchPointsBuilder(
//              touches: touchOutput,
//              in: mapStrategy.size(for: proxy.size, aspectRatio: CGSize.trackpadAspectRatio)
//            )
//            let mapped = mappedTouchBuilder.mappedTouches
            self.localMappedTouches = touchOutput
          }

          didUpdateTouches(touchOutput)

          /// Handle touches for View using the modifier
          //          touchUpdates(touches)
        } didUpdatePressure: { pressure in
          
        } // touches view
        .background(.cyan.opacity(0.1))
        .debugTextOverlay("No viewport size", isEnabled: viewportSize == nil)
      }  // END isEnabled check
    }  // END geo reader
  }
}
extension View {

  public func touches(
    isEnabled: Bool = true,
    mapStrategy: ContentSizeMode,
    showIndicators: Bool = true,
    didUpdateTouches: @escaping TouchesUpdate,
    didUpdatePressure: @escaping PressureUpdate
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
