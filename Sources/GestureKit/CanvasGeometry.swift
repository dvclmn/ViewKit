//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import Foundation
import CoreTools

public struct CanvasGeometry: Sendable, Equatable {
  public var viewportSize: CGSize
  public var canvasSize: CGSize

  /// Initialise with zero, so the instance gets set up,
  /// and then can update at runtime
  public init(
    viewportSize: CGSize = .zero,
    canvasSize: CGSize = .zero,
  ) {
    self.viewportSize = viewportSize
    self.canvasSize = canvasSize
  }
}

extension CanvasGeometry {
  public var isEitherZero: Bool { viewportSize.isZero || canvasSize.isZero }
}
extension CanvasGeometry: CustomStringConvertible {
  public var description: String {
    DisplayString {
//      "Hello"
      Labeled("Viewport", value: viewportSize)
      Labeled("Canvas", value: canvasSize)
    }
    .decimalPlaces(0)
    .labelStyle(.none)
    .text
      
  }
}
