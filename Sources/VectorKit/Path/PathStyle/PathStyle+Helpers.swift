//
//  PathStyle+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/1/2026.
//

//import Foundation

// Look into this macro:
// https://github.com/aibobrov/EnumPath
//extension PathStyle {
  /// A "stable" property for the radius, even if not currently in the `stamped` case
  /// This allows a e.g. Stepper to bind to something without the code crashing
//  var radius: CGFloat {
//    get {
//      if case .stamped(let config) = self {
//        return config.radius
//      }
//      return Self.stampedDefault
//    }
//    set {
//      if case .stamped(let config) = self {
//        let newConfig = StampedConfig(shape: config.shape, radius: newValue)
//        self = .stamped(newConfig)
//      }
//    }
//  }
//
//  var pointShape: PointShape {
//    get {
//      if case .stamped(let shape, _) = self { return shape }
//      return .circle
//    }
//    set {
//      if case .stamped(_, let radius) = self {
//        self = .stamped(shape: newValue, radius: radius)
//      }
//    }
//  }
//}
