//
//  TrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import Foundation

public protocol SliderTrackStyle {
  associatedtype Body: View
  func makeBody(configuration: SliderTrackConfiguration) -> Body
}

/// ```
/// public struct HSVHueTrackStyle: SliderTrackStyle {
///   public func makeBody(configuration: SliderTrackConfiguration) -> some View {
///     RoundedRectangle(cornerRadius: 8, style: .continuous)
///       .fill(LinearGradient.rainbow())
///   }
/// }
/// ```
///
/// ```
/// public struct OpacityCheckerboardTrackStyle: SliderTrackStyle {
///   public func makeBody(configuration: SliderTrackConfiguration) -> some View {
///     ZStack {
///       CheckerboardView() // your checkerboard view
///       LinearGradient(
///         colors: [.clear, .white],
///         startPoint: .leading,
///         endPoint: .trailing
///       )
///     }
///     .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
///   }
/// }
/// ```
public struct AnySliderTrackStyle: SliderTrackStyle {
  private let _makeBody: (SliderTrackConfiguration) -> AnyView

  public init<S: SliderTrackStyle>(_ style: S) {
    self._makeBody = { AnyView(style.makeBody(configuration: $0)) }
  }

  public func makeBody(configuration: SliderTrackConfiguration) -> some View {
    _makeBody(configuration)
  }
}

//extension View {
//  func setEffectShouldPulse(_ shouldPulse: Bool) -> some View {
//    self.environment(\.effectShouldPulse, shouldPulse)
//  }
//}

//private struct SliderTrackStyleKey: EnvironmentKey {
//  static let defaultValue: AnySliderTrackStyle = AnySliderTrackStyle(DefaultSliderTrackStyle())
//}
//
//public extension EnvironmentValues {
//  var sliderTrackStyle: AnySliderTrackStyle {
//    get { self[SliderTrackStyleKey.self] }
//    set { self[SliderTrackStyleKey.self] = newValue }
//  }
//}
