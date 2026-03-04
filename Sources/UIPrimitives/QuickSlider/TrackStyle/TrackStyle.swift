//
//  TrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

public protocol SliderTrackStyle {
  associatedtype Body: View
  typealias Configuration = SliderTrackConfiguration
  @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

struct AnySliderTrackStyle<Content: View>: SliderTrackStyle {
  private let _makeBody: (Configuration) -> Content
  typealias Body = Content

  init(_ makeBody: @escaping (Configuration) -> Content) {
    self._makeBody = makeBody
  }

  init<S: SliderTrackStyle>(_ style: S) where S.Body == Content {
    self._makeBody = { configuration in
      style.makeBody(configuration: configuration)
    }
  }

  @ViewBuilder func makeBody(configuration: Configuration) -> Content {
    _makeBody(configuration)
  }
}

extension SliderTrackStyle {
  func eraseToAnySliderTrackStyle() -> AnySliderTrackStyle<Body> {
    AnySliderTrackStyle(self)
  }
}

public struct DefaultSliderTrackStyle: SliderTrackStyle {
  public init() {}
  public func makeBody(configuration: Configuration) -> some View {
    RoundedRectangle(cornerRadius: 8, style: .continuous)
      .fill(.secondary.opacity(0.25))
  }
}

public struct AnySliderTrackStyleBox: SliderTrackStyle {
  public typealias Body = AnyView
  private let _makeBody: (Configuration) -> AnyView

  public init<S: SliderTrackStyle>(_ style: S) {
    self._makeBody = { configuration in
      AnyView(style.makeBody(configuration: configuration))
    }
  }

  @ViewBuilder public func makeBody(configuration: Configuration) -> AnyView {
    _makeBody(configuration)
  }
}

public extension SliderTrackStyle {
  /// Erase a concrete `SliderTrackStyle` to a non-generic box suitable for use in Environment.
  func eraseToEnvironmentTrackStyle() -> AnySliderTrackStyleBox {
    AnySliderTrackStyleBox(self)
  }
}

//private struct SliderTrackStyleKey: EnvironmentKey {
//  static let defaultValue: AnySliderTrackStyleBox = AnySliderTrackStyleBox(DefaultSliderTrackStyle())
//}
//
//public extension EnvironmentValues {
//  var sliderTrackStyle: AnySliderTrackStyleBox {
//    get { self[SliderTrackStyleKey.self] }
//    set { self[SliderTrackStyleKey.self] = newValue }
//  }
//}

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
//public struct SliderTrackStyle: TrackStyle {
//  private let _makeBody: (SliderTrackConfiguration) -> some View
//
//  public init<S: SliderTrackStyle>(_ style: S) {
//    self._makeBody = { AnyView(style.makeBody(configuration: $0)) }
//  }
//
//  public func makeBody(configuration: SliderTrackConfiguration) -> some View {
//    _makeBody(configuration)
//  }
//}
//
//extension AnySliderTrackStyle {
//  public static let default: Self = .init(.makeBody(.init(value: <#T##Double#>, range: <#T##ClosedRange<Double>#>, colorScheme: <#T##ColorScheme#>, tint: <#T##Color#>)))
//}

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

