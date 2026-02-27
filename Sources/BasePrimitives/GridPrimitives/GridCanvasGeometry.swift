//
//  GridCanvasGeometry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation
import CoreGraphics

public struct GridCanvasGeometry: GeometryContext, Sendable, Equatable {
  public var viewportRect: CGRect
  public var subjectSize: GridDimensions
  
  public init(
    viewportRect: CGRect = .zero,
    subjectSize: GridDimensions = .zero,
  ) {
    self.viewportRect = viewportRect
    self.subjectSize = subjectSize
  }
}
