//
//  Stamped.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import SwiftUI

extension WavePathGenerator {
  /// Allows injecting stamping behaviour (adding shapes at points in a path)
  /// without the path processors needing to know anything about the stamping logic itself.
  ///
  /// Separates the concerns of “how the path is interpolated” from “what is stamped at each point.”
  func makeStampClosure(from style: FloatPointStyle?) -> Stamper {
    guard let style else { return { _, _, _ in } }
    return { index, point, path in
      style.shape.addShape(to: &path, at: point, radius: style.radius)
    }
  }
}
