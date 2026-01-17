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
  var style: PathStylePicker
  var shape: PointShape
  var radius: CGFloat
  
  static let smooth: Self = .init(style: .smooth)
  
  init(
    style: PathStylePicker,
    shape: PointShape = .circle,
    radius: CGFloat = 3
  ) {
    self.style = style
    self.shape = shape
    self.radius = radius
  }
}

extension PathStyleConfig {
  var toPathStyle: PathStyle {
    switch style {
      case .line: .line
      case .smooth: .smooth
      case .stamped: .stamped(shape: shape, radius: radius)
    }
  }
  mutating func updateStyle(_ newStyle: PathStylePicker) {
    self.style = newStyle
//    self = Self(style: newStyle, shape: shape, radius: radius)
  }
}

@CaseDetection
enum PathStylePicker: String, Identifiable, Pickable {
  case line
  case smooth
  case stamped
  
  var id: String { rawValue }
  
//  init(from pathStyle: PathStyle) {
//    self = switch pathStyle {
//      case .line: .line
//      case .smooth: .smooth
//      case .stamped: .stamped
//    }
//  }
}
