//
//  PathStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CasePaths
import CoreTools
import SwiftUI

/// Path style with optional stamping effect
public struct PathStyle {
  let interpolation: WaveInterpolation
  let stamped: FloatPointStyle?
}

extension PathStyle {

  //  public var id: UUID {
  //    switch self {
  //      case .line: UUID(fromInt: 1)
  //      case .smooth: UUID(fromInt: 1)
  //      case .stamped(let config): config.id
  //    }
  //  }

  //  public var label: QuickLabel {
  //    switch self {
  //      case .line: .init("Line")
  //      case .smooth: .init("Smooth")
  //      case .stamped(let config): .init("Stamp (\(config.shape.name)), radius: \(config.radius.toString))")
  //    }
  //  }

  //  public static func stamped(_ shape: PointShape, radius: CGFloat) -> Self {
  //    .stamped(.init(shape: shape, radius: radius))
  //  }

  public var kind: PathStyle.Meta { Self.Meta(self) }

  public static func make(
    kind: PathStyle.Meta,
    preserving old: PathStyle?
  ) -> PathStyle {
    switch kind {
      case .line:
        return .line

      case .smooth:
        return .smooth

      case .stamped:
        guard case .stamped(let shape, let radius) = old else {
          //        guard case .stamped(let config) = old else {
          return .stampedDefault
        }
        return .stamped(shape: shape, radius: radius)
    }
  }

  //  public mutating func updateStampRadius(_ newValue: CGFloat) {
  //    guard case .stamped(let shape, _) = self else { return }
  //    self = .stamped(shape: shape, radius: newValue)
  //  }
  //
  //  public mutating func updateStampShape(_ newValue: PointShape) {
  //    guard case .stamped(_, let radius) = self else { return }
  //    self = .stamped(shape: newValue, radius: radius)
  //  }
}

extension PathStyle.Meta: Pickable {
  public static var pickerLabel: QuickLabel { "Path Style" }
  public var label: QuickLabel { .init(self.name) }
}

//struct PathStyleConfig {
//  var style: PathStyle.Meta
////  var shape: PointShape
////  var radius: Double
////  var range: ClosedRange<Double>
//
//  static let smooth: Self = .init(style: .smooth)
//
//  init(
//    style: PathStyle.Meta,
//    shape: PointShape = .circle,
//    radius: CGFloat = 3,
//    range: ClosedRange<Double> = 0.1...90
//  ) {
//    self.style = style
//    self.shape = shape
//    self.radius = radius
//    self.range = range
//  }
//}

//extension PathStyleConfig {
//  var clampedRadius: CGFloat { radius.clamped(to: range) }
//
//  var toPathStyle: PathStyle {
//    switch style {
//      case .line: .line
//      case .smooth: .smooth
//      case .stamped: .stamped(shape: shape, radius: clampedRadius)
//    }
//  }
//  mutating func updateStyle(_ newStyle: PathStyle.Meta) {
//    self.style = newStyle
////    self = Self(style: newStyle, shape: shape, radius: radius)
//  }
//}

//@CaseDetection
//enum PathStylePicker: String, Identifiable, Pickable {
//  case line
//  case smooth
//  case stamped
//
//  var id: String { rawValue }
//
////  init(from pathStyle: PathStyle) {
////    self = switch pathStyle {
////      case .line: .line
////      case .smooth: .smooth
////      case .stamped: .stamped
////    }
////  }
//}
