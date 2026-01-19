//
//  PathStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CoreTools
import SwiftUI

enum PathStyleKind: String, CaseIterable, Pickable {
  static var pickerLabel: QuickLabel { "Path Style" }

  case line
  case smooth
  case stamped
}

@CaseDetection
@AssociatedValues
@MetaEnum
public enum PathStyle: Sendable, Hashable, Codable {
  case line
  case smooth
  case stamped(StampedConfig)
  //  case stamped(shape: PointShape, radius: CGFloat, range: ClosedRange<Double>)
  //  public var id: String { rawValue }

  public static var stampedDefault: Self { .stamped(.init()) }
}

extension PathStyle {
  var kind: PathStyleKind {
    switch self {
      case .line: .line
      case .smooth: .smooth
      case .stamped: .stamped
    }
  }

  static func make(
    kind: PathStyleKind,
    preserving old: PathStyle?
  ) -> PathStyle {
    switch kind {
      case .line:
        return .line

      case .smooth:
        return .smooth

      case .stamped:
        guard case .stamped(let shape, let radius) = old else {
          return .stampedDefault
        }
        return .stamped(shape: shape, radius: radius)
    }
  }
  
  var stampedConfig: Binding<StampedConfig>? {
    guard case let .stamped(shape, radius) = self else { return nil }
    
    return Binding(
      get: { StampedConfig(shape: shape, radius: radius) },
      set: { new in
        self = .stamped(shape: new.shape, radius: new.radius)
      }
    )
  }

  //  var stampedRadius: CGFloat? {
  //    if case let .stamped(_, radius) = self {
  //      return radius
  //    }
  //    return nil
  //  }

  mutating func updateStampRadius(_ newValue: CGFloat) {
    guard case .stamped(let shape, _) = self else { return }
    self = .stamped(shape: shape, radius: newValue)
  }

  mutating func updateStampShape(_ newValue: PointShape) {
    guard case .stamped(_, let radius) = self else { return }
    self = .stamped(shape: newValue, radius: radius)
  }
}

extension PathStyle.Meta: Pickable, Identifiable {
  public var id: String { name }
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
