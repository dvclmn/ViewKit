//
//  Path+Smooth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import CoreTools
import SwiftUI

@CaseDetection
@AssociatedValues
@MetaEnum
public enum PathStyle: Sendable, Hashable, Codable {
  case line
  case smooth
  case stamped(shape: PointShape, radius: CGFloat)
  //  case stamped(shape: PointShape, radius: CGFloat, range: ClosedRange<Double>)
  //  public var id: String { rawValue }

}

extension PathStyle {
//  var stampedRadius: CGFloat? {
//    if case let .stamped(_, radius) = self {
//      return radius
//    }
//    return nil
//  }

  mutating func updateStampRadius(_ newValue: CGFloat) {
    guard case let .stamped(shape, _) = self else { return }
    self = .stamped(shape: shape, radius: newValue)
  }
  
  mutating func updateStampShape(_ newValue: PointShape) {
    guard case let .stamped(_, radius) = self else { return }
    self = .stamped(shape: newValue, radius: radius)
  }
}


extension PathStyle.Meta: Pickable, Identifiable {
  public var id: String { name }
  public static var pickerLabel: QuickLabel { "Path Style" }
  public var label: QuickLabel { .init(self.name) }
}

extension Array where Element == CGPoint {

  public func toPath(
    type: PathStyle = .line,
    shouldDropFirst: Bool = true
  ) -> Path {
    Path { path in
      processPath(type: type, shouldDropFirst: shouldDropFirst, path: &path)
    }
  }

  public func processPath(
    type: PathStyle = .line,
    shouldDropFirst: Bool = true,
    path: inout Path
  ) {
    switch type {
      case .line:
        processLinePath(
          shouldDropFirst: shouldDropFirst,
          path: &path
        )

      case .smooth:
        processSmoothPath(path: &path)

      case .stamped(let shape, let radius):
        //      case .stamped(let shape, let radius, let range):
        processStampedPath(
          shouldDropFirst: shouldDropFirst,
          shape: shape,
          radius: radius,
          path: &path
        )
    }
  }

  private func processLinePath(
    shouldDropFirst: Bool = true,
    path: inout Path
  ) {
    guard let firstPoint = self.first else { return }
    let lines = shouldDropFirst ? Array(self.dropFirst()) : self
    path.move(to: firstPoint)
    path.addLines(lines)
  }

  private func processStampedPath(
    shouldDropFirst: Bool = true,
    shape: PointShape,
    radius: CGFloat,
    path: inout Path
  ) {
    guard let firstPoint = self.first else { return }
    let lines = shouldDropFirst ? Array(self.dropFirst()) : self
    path.move(to: firstPoint)
    for point in lines {
      path.addShape(at: point, radius: radius, using: shape)
    }
    //    path.addLines(lines)
  }

  /// Alternative: Smooth curved path using quadratic curves
  private func processSmoothPath(
    path: inout Path
  ) {
    guard self.count > 1 else { return }

    path.move(to: self[0])

    if self.count == 2 {
      path.addLine(to: self[1])
      return
    }

    /// Create smooth curves between points
    for i in 1..<self.count {
      let current = self[i]

      if i == self.count - 1 {
        /// Last point - just draw line
        path.addLine(to: current)

      } else {
        /// Use next point to create control point for smooth curve
        let next = self[i + 1]
        let controlPoint = CGPoint(
          x: (current.x + next.x) / 2,
          y: (current.y + next.y) / 2
        )
        path.addQuadCurve(to: controlPoint, control: current)
      }
    }
  }
}
