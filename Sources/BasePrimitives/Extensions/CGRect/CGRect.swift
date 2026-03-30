//
//  CGRect.swift
//  Collection
//
//  Created by Dave Coleman on 9/12/2024.
//

import SwiftUI

extension CGRect {

  public var isZero: Bool { width == 0 && height == 0 }

  public init(x: Float, y: Float, width: Float, height: Float) {
    self.init(x: Double(x), y: Double(y), width: Double(width), height: Double(height))
  }

  public init?<T: BinaryFloatingPoint>(fromArray array: [T]) {
    guard let x = array[safe: 0],
      let y = array[safe: 1],
      let width = array[safe: 2],
      let height = array[safe: 3]
    else { return nil }
    self.init(
      x: CGFloat(x),
      y: CGFloat(y),
      width: CGFloat(width),
      height: CGFloat(height),
    )
  }

  public var isStandardized: Bool {
    return !isNull && !isInfinite
      && origin.x.isFinite && origin.y.isFinite
      && width.isFinite && height.isFinite
      && width >= 0 && height >= 0
  }

  public var path: Path { Path(self) }

  public func edgePoints(for edge: Edge) -> (start: CGPoint, end: CGPoint) {
    switch edge {
      case .top: (CGPoint(x: minX, y: minY), CGPoint(x: maxX, y: minY))
      case .bottom: (CGPoint(x: minX, y: maxY), CGPoint(x: maxX, y: maxY))
      case .leading: (CGPoint(x: minX, y: minY), CGPoint(x: minX, y: maxY))
      case .trailing: (CGPoint(x: maxX, y: minY), CGPoint(x: maxX, y: maxY))
    }
  }

  /// Returns the centre point of this rectangle
  public var midpoint: CGPoint { center }

  /// Produces a CGRect positioned inside the container, aligned
  /// according to the given UnitPoint.
  ///
  /// Note: This mirrors how alignment guides work in SwiftUI — the origin of the
  /// rect shifts so that the point described by anchor within the container aligns
  /// to the same point in the rect.
  public func aligned(
    in container: CGSize,
    to anchor: UnitPoint = .center,
  ) -> CGRect {
    let origin = CGPoint(
      x: (container.width - width) * anchor.x,
      y: (container.height - height) * anchor.y,
    )
    return CGRect(origin: origin, size: size)
  }

  public func aligned(
    in container: CGRect,
    to anchor: UnitPoint = .center,
  ) -> CGRect {
    let baseOrigin = aligned(in: container.size, to: anchor).origin
    let origin = CGPoint(
      x: container.minX + baseOrigin.x,
      y: container.minY + baseOrigin.y,
    )
    return CGRect(origin: origin, size: size)
  }

  //  func aligned(
  //    in container: CGRect,
  //    to anchor: UnitPoint = .center
  //  ) -> CGRect {
  //    let base = aligned(in: container.size, to: anchor)
  //    let originAdjusted = container.midpoint + base.origin
  //    return CGRect(origin: originAdjusted, size: size)
  ////    let origin = CGPoint(
  ////      x: container.origin.x + (container.size.width - width) * anchor.x,
  ////      y: container.origin.y + (container.size.height - height) * anchor.y
  ////    )
  ////    return CGRect(origin: origin, size: size)
  //  }

  /// Returns a rectangle that encompasses both this rectangle and the provided rectangle
  public func expanded(toInclude rect: CGRect) -> CGRect {
    /// Using built-in union method
    return union(rect)
  }

  /// Creates a rectangle from two points, ensuring positive width and height
  /// Useful for drag operations like marquee selection where the drag direction is unknown
  ///
  /// Note: previous methods `reversible`, `fromPoints(_:_:)`,
  /// `between(point1:point2:)`
  public static func boundingRect(
    from start: CGPoint, to end: CGPoint,
  ) -> CGRect {
    let size = CGSize(
      width: end.x - start.x,
      height: end.y - start.y,
    )
    return CGRect(origin: start, size: size).standardized
  }

  public static let exampleZeroOrigin100x100 = CGRect(
    origin: .zero, size: CGSize(100, 100),
  )

}

// MARK: - Convenience initialisers
extension CGRect {

  /// Creates a rect with an origin of zero, and size from provided `size`
  public init(fromSize size: CGSize) {
    self.init(origin: .zero, size: size)
  }

  /// Useful for occasions where origin and size properties
  /// are already defined, just need to be plugged in,
  /// and an extra-quick init is helpful
  public init(_ origin: CGPoint, _ size: CGSize) {
    self.init(origin: origin, size: size)
  }

  /// Creates a rectangle with the given size, centered within the container size
  public init(size: CGSize, centeredIn containerSize: CGSize) {
    let origin = CGPoint(
      x: (containerSize.width - size.width) / 2,
      y: (containerSize.height - size.height) / 2,
    )
    self.init(origin: origin, size: size)
  }

}
