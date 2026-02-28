//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import CoreTools
import SwiftUI

public struct CanvasGeometry: GeometryContext, Sendable, Equatable {
  public var viewportRect: CGRect
  public var subjectSize: CGSize
  public var subjectAnchor: UnitPoint

  /// Initialise with zero, so the instance gets set up,
  /// and then can update at runtime
  public init(
    viewportRect: CGRect = .zero,
    subjectSize: CGSize = .zero,
    subjectAnchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.subjectSize = subjectSize
    self.subjectAnchor = subjectAnchor
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
