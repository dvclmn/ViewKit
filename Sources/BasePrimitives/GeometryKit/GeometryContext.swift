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
//  public var isEitherZero: Bool { viewportRect.isZero || subjectSize.isZero }
  public var subjectAnchor: UnitPoint { .center }
}
