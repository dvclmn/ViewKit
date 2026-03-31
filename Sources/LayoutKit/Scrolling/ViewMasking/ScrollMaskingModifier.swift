//
//  ViewMaskingModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 22/5/2025.
//

import BasePrimitives
import SwiftUI
import GeometryPrimitives

public struct ScrollMaskModifier: ViewModifier {

  @State private var scrollLocation: ScrollLocation = .start

  /// Establishing that here in this Scroll masking domain,
  /// when talking about width, we mean the *horizontal* axis
  private let axisConvention: AxisMapping = .identity

  let axis: Axis
  let areasToMask: ScrollMaskArea
  let fallOffLength: CGFloat
  let debounceInterval: TimeInterval

  public func body(content: Content) -> some View {
    content

      /// For a better visual indication of how the masking works,
      /// change this from `.mask` to `.overlay`
      ///
      /// Just don't forget to change it back!
      .mask {
        ZStack {
          /// This handles the mask 'falloff', on either end (as set by the user).
          DynamicStack(axis: axis, spacing: 0) {
            MaskEnd()
            /// This is just an opaque area, keeping the
            /// View visible between masked areas
            Color.cyan
            MaskStart()
          }

          /// Controls clean fading in/out of masked portions
          DynamicStack(axis: axis, spacing: 0) {
            /// Leading / Top
            Color.orange.opacity(isStartMasked ? 0 : 1)

            /// Trailing/Bottom
            Color.green.opacity(isEndMasked ? 0 : 1)
          }  // END dynamic layout

        }
        .allowsHitTesting(false)
        .animation(Styles.animationQuickNSmooth, value: isStartMasked)
        .animation(Styles.animationQuickNSmooth, value: isEndMasked)

      }  // END mask
      .getScrollContext(axis: .vertical, debounce: .debounce(debounceInterval)) { context in
        print("Scroll location: \(context.location)")
        self.scrollLocation = context.location
      }
  }
}

extension ScrollMaskModifier {

  private var gradientSpan: UnitSpan {
    return axis.toGradientSpan()
  }
  var isStartMasked: Bool {
    guard areasToMask.contains(.start) else { return false }
    return scrollLocation == .end || scrollLocation == .mid
  }

  var isEndMasked: Bool {
    guard areasToMask.contains(.end) else { return false }
    return scrollLocation == .start || scrollLocation == .mid
  }

  @ViewBuilder
  func MaskEnd() -> some View {
    SmoothLinearGradient(
      from: Color.clear,
      to: Color.cyan,
      startPoint: gradientSpan.start,
      endPoint: gradientSpan.end,
    )
    .frame(width: maskFrameSize.0, height: maskFrameSize.1)
    .transition(.opacity)

  }

  @ViewBuilder
  func MaskStart() -> some View {
    SmoothLinearGradient(
      from: Color.cyan,
      to: Color.clear,
      startPoint: gradientSpan.start,
      endPoint: gradientSpan.end,
    )
    .frame(width: maskFrameSize.0, height: maskFrameSize.1)
    .transition(.opacity)
  }

  var maskFrameSize: (CGFloat?, CGFloat?) {
    /// For horizontal, falloff means width
    /// For vertical, it means height
    let length: CGFloat = max(0, fallOffLength)

    switch axis {
      case .horizontal:
        return (length, nil)

      case .vertical:
        return (nil, length)
    }
  }

}

extension View {

  public func scrollMask(
    axis: Axis,
    areasToMask: ScrollMaskArea = .all,
    fallOffLength: CGFloat = 20,
    debounceInterval: TimeInterval = 0.2
  ) -> some View {
    self.modifier(
      ScrollMaskModifier(
        axis: axis,
        areasToMask: areasToMask,
        fallOffLength: fallOffLength,
        debounceInterval: debounceInterval
      )
    )
  }
}
