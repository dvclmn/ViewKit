//
//  Stamped.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import SwiftUI

extension WavePathGenerator {
  func makeStampClosure(from style: FloatPointStyle?) -> Stamper {
    guard let style else { return { _, _, _ in } }
    return { index, point, path in
      style.shape.addShape(to: &path, at: point, radius: style.radius)
    }
  }
}
