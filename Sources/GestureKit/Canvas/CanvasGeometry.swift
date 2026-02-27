//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import CoreTools
import Foundation

public struct CanvasGeometry: GeometryContext, Sendable, Equatable {
  public var viewportRect: CGRect
  public var subjectSize: CGSize

  /// Initialise with zero, so the instance gets set up,
  /// and then can update at runtime
  public init(
    viewportRect: CGRect = .zero,
    subjectSize: CGSize = .zero,
  ) {
    self.viewportRect = viewportRect
    self.subjectSize = subjectSize
  }
}

extension CanvasGeometry {
  public var canvasSize: CGSize {
    get { subjectSize }
    set { subjectSize = newValue }
  }
}

extension CanvasGeometry: CustomStringConvertible {
  public var description: String {
    DisplayString {
      //      "Hello"
      Labeled("Viewport Rect", value: viewportRect)
      Labeled("Canvas", value: canvasSize)
    }
    .decimalPlaces(0)
    .labelStyle(.none)
    .text

  }

}
