//
//  GeometryContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/2/2026.
//

import CoreGraphics
import SwiftUI

/// This aims to express concepts similar to previous models `GridGeometry`,
/// `CanvasGeometry`, `ArtworkGeometry` etc. It's meant to help with situating
/// one known rect within another known rect, coordinate space conversions, etc
public protocol GeometryContext {
  associatedtype Size: DomainSize

  /// Uses rect,  not size, to express safe area insets. Usually provided
  /// by `ViewSizeModifier` / `GeometryCapturable` domains
  var viewportRect: CGRect { get set }
  var subjectSize: Size { get set }
  var subjectAnchor: UnitPoint { get }
  //  var unitSize: UnitSize { get }
}

extension GeometryContext {
  public var isEitherZero: Bool { viewportRect.isZero || subjectSize.isZero }
  public var subjectAnchor: UnitPoint { .center }
}

/// Intended as a bit of an analogue to CanvasGeometry for Grid artwork
public struct GridGeometry: GeometryContext {
  /// A rect, not a size, to express safe area insets
  public var viewportRect: CGRect
  public var subjectSize: GridDimensions

  //  let environment: EnvironmentValues

  public init(
    viewportRect: CGRect,
    subjectSize: GridDimensions,
    //    environment: EnvironmentValues
  ) {
    self.viewportRect = viewportRect
    self.subjectSize = subjectSize
    //    self.environment = environment
  }
}

extension GridGeometry {

  //  private var canvasSize: CGSize? {
  //    guard let unitSize else { return nil }
  //    guard let gridDimensions else { return nil }
  //
  //    //    let dimensions = gridCanvas.wrappedValue.gridDimensions
  //    return gridDimensions.toScreenSize(using: unitSize)
  //  }
}
