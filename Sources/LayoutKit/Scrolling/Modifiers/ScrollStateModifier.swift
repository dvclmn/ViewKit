//
//  ScrollGeometry.swift
//  BaseComponents
//
//  Created by Dave Coleman on 8/3/2025.
//

import CoreTools
import SwiftUI

public struct ScrollStateModifier: ViewModifier {
  @State private var debouncer: AsyncDebouncer?
  @State private var hasUpdatedScrollLocation: Bool = false

  /// Only supports one Axis at a time
  let axis: Axis
  let tolerance: CGFloat
  let didUpdateScrollContext: (ScrollContext) -> Void

  public init(
    axis: Axis,
    tolerance: CGFloat,
    debounce: DebounceMode,
    didUpdateScrollContext: @escaping (ScrollContext) -> Void
  ) {
    self.axis = axis
    self.tolerance = tolerance
    self._debouncer = debounce.createDebouncer()
    self.didUpdateScrollContext = didUpdateScrollContext
  }

  public func body(content: Content) -> some View {
    if #available(macOS 15, iOS 18, *) {
      content
        .onScrollGeometryChange(for: ScrollContext.self) { geometry in
          return ScrollContext(
            fromGeometry: geometry,
            withAxis: axis.toGridAxis,
            tolerance: tolerance
          )

        } action: { oldValue, newValue in

          /// Note: `hasUpdatedScrollLocation`is being used to skip
          /// debouncing for the very first scroll update.

          /// First time: `hasUpdatedScrollLocation` is false, so the
          /// guard triggers, sets it to `true`, and immediately calls
          /// `didUpdateScrollContext(newValue)` without debouncing.
          ///
          /// Subsequent times: `hasUpdatedScrollLocation` is now `true`,
          /// so the guard fails and execution continues to the debounced Task block
          guard hasUpdatedScrollLocation else {
            hasUpdatedScrollLocation = true
            return didUpdateScrollContext(newValue)
          }

          Task.debounceIfNeeded(debouncer) {
            performIfChanged(oldValue, newValue, perform: didUpdateScrollContext(newValue))
          }
        }
    } else {
      /// Falling back to plain old View for macOS 14 and lower
      content
    }
  }
}

extension View {
  /// The current location of the attached `ScrollView`, along it's scrollable area
  /// - Parameters:
  ///   - axis: The scrollable axes of the scroll view.
  ///   - tolerance: How far can be scrolled before `start` is no longer true
  ///   - debounceInterval: Interval to debounce scroll events
  ///   - didUpdateScrollContext: A callback for when the scroll location is updated
  /// - Returns: An enum describing basic locations along a scrollable area
  public func getScrollContext(
    axis: Axis,
    tolerance: CGFloat = 2.0,
    debounce: DebounceMode = .debounce(0.2),
    //    debounceInterval: TimeInterval = 0.2,
    didUpdateScrollContext: @escaping (ScrollContext) -> Void
  ) -> some View {
    self.modifier(
      ScrollStateModifier(
        axis: axis,
        tolerance: tolerance,
        debounce: debounce,
        //        debounceInterval: debounceInterval,
        didUpdateScrollContext: didUpdateScrollContext
      )
    )
  }
}
