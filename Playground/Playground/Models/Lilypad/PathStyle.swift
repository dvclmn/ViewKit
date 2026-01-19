//
//  PathStyle.swift
//  Playground
//
//  Created by Dave Coleman on 17/1/2026.
//

import CoreTools
import VectorKit
import Foundation

struct PathStyleConfig {
  var style: PathStyle.Meta
  var shape: PointShape
  var radius: Double
  var range: ClosedRange<Double>
  
  static let smooth: Self = .init(style: .smooth)
  
  init(
    style: PathStyle.Meta,
    shape: PointShape = .circle,
    radius: CGFloat = 3,
    range: ClosedRange<Double> = 0.1...90
  ) {
    self.style = style
    self.shape = shape
    self.radius = radius
    self.range = range
  }
}

extension PathStyleConfig {
  var clampedRadius: CGFloat { radius.clamped(to: range) }
  
  var toPathStyle: PathStyle {
    switch style {
      case .line: .line
      case .smooth: .smooth
      case .stamped: .stamped(shape: shape, radius: clampedRadius)
    }
  }
  mutating func updateStyle(_ newStyle: PathStyle.Meta) {
    self.style = newStyle
//    self = Self(style: newStyle, shape: shape, radius: radius)
  }
}

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
