//
//  VariableWidthPath.swift
//  Paperbark
//
//  Created by Dave Coleman on 31/5/2025.
//

//import SwiftUI
//import InteractionKit
//
//public struct VariableWidthPath {
//  var leftEdge: [CGPoint] = []
//  var rightEdge: [CGPoint] = []
//
//  var pendingFirstPoint: CGPoint?
//  var previousNormal: CGPoint?
//  var previousWidth: CGFloat?
//  
//  public init(
//    leftEdge: [CGPoint] = [],
//    rightEdge: [CGPoint] = [],
//    pendingFirstPoint: CGPoint? = nil,
//    previousNormal: CGPoint? = nil,
//    previousWidth: CGFloat? = nil
//  ) {
//    self.leftEdge = leftEdge
//    self.rightEdge = rightEdge
//    self.pendingFirstPoint = pendingFirstPoint
//    self.previousNormal = previousNormal
//    self.previousWidth = previousWidth
//  }
//}
//
//extension VariableWidthPath {
//
//  var fallBackPath: Path {
//    var path = Path()
//    if let point = self.leftEdge.first ?? self.rightEdge.first {
//      path.addEllipse(in: CGRect(origin: point, size: .zero).insetBy(dx: -1, dy: -1))
//    }
//    return path
//  }
//
//  var pathEdgesAreValid: Bool {
//    guard self.leftEdge.count == self.rightEdge.count,
//      !self.leftEdge.isEmpty
//    else { return false }
//    return true
//  }
//
//  func generatePath(
//    usesSmoothCurves: Bool = false,
//    closed: Bool = true
//  ) -> Path {
//
//    var path = Path()
//    guard pathEdgesAreValid else {
//      /// Fall back to a reasonable default
//      return fallBackPath
//    }
//
//    if usesSmoothCurves {
//      generateSmoothQuadPath(&path, closed: closed)
//
//    } else {
//      generateLineBasedPath(&path, closed: closed)
//    }
//    return path
//  }
//
//  private func generateLineBasedPath(
//    _ path: inout Path,
//    closed: Bool
//  ) {
//    path.move(to: leftEdge[0])
//
//    for pt in leftEdge.dropFirst() {
//      path.addLine(to: pt)
//    }
//
//    for pt in rightEdge.reversed() {
//      path.addLine(to: pt)
//    }
//    if closed {
//      path.closeSubpath()
//    }
//  }
//
//  private func generateSmoothQuadPath(
//    _ path: inout Path,
//    closed: Bool
//  ) {
//    // --- Left edge (forward)
//    path.move(to: leftEdge[0])
//
//    for i in 1..<leftEdge.count {
//      let prev = leftEdge[i - 1]
//      let curr = leftEdge[i]
//      let mid = CGPoint(
//        x: (prev.x + curr.x) / 2,
//        y: (prev.y + curr.y) / 2
//      )
//      path.addQuadCurve(to: mid, control: prev)
//    }
//
//    // Connect final segment to the actual last point
//    path.addLine(to: leftEdge.last!)
//
//    // --- Right edge (reverse)
//    // This walks the right edge in reverse to close the stroke
//    path.addLine(to: rightEdge.last!)  // First point of the reverse path
//
//    for i in (1..<rightEdge.count).reversed() {
//      let curr = rightEdge[i]
//      let prev = rightEdge[i - 1]
//      let mid = CGPoint(
//        x: (curr.x + prev.x) / 2,
//        y: (curr.y + prev.y) / 2
//      )
//      path.addQuadCurve(to: mid, control: curr)
//    }
//
//    // Connect back to starting point
//    path.addLine(to: rightEdge[0])
//    //    path.closeSubpath()
//
//    if closed {
//      path.closeSubpath()
//    }
//
//  }
//
//  public mutating func addPoint(
//    to current: CGPoint,
//    rawWidth: CGFloat
//  ) {
//
//    //    if let last = leftEdge.last, (current - last).lengthSquared() < 1.0 {
//    //      return // too close, skip
//    //    }
//
//    let smoothedWidth: CGFloat
//    if let prevWidth = previousWidth {
//      smoothedWidth = prevWidth * 0.85 + rawWidth * 0.15
//    } else {
//      smoothedWidth = rawWidth
//    }
//    previousWidth = smoothedWidth
//
//    if pendingFirstPoint == nil {
//      pendingFirstPoint = current
//      return
//    }
//
//    if let pending = pendingFirstPoint {
//      if let (left, right, normal) = computeSmoothedOffset(
//        from: pending, to: current, width: smoothedWidth
//      ) {
//        leftEdge.append(left)
//        rightEdge.append(right)
//        previousNormal = normal
//      }
//      pendingFirstPoint = nil
//      return
//    }
//
//    if previousNormal != nil {
//      if let (left, right, normal) = computeSmoothedOffset(
//        from: leftEdge.last!, to: current, width: smoothedWidth
//      ) {
//        leftEdge.append(left)
//        rightEdge.append(right)
//        self.previousNormal = normal
//      }
//    }
//  }
//
//  private mutating func computeSmoothedOffset(
//    from previous: CGPoint,
//    to current: CGPoint,
//    width: CGFloat
//  ) -> (left: CGPoint, right: CGPoint, normal: CGPoint)? {
//    let direction = CGPoint(
//      x: current.x - previous.x,
//      y: current.y - previous.y
//    )
//    let length = hypot(direction.x, direction.y)
//    guard length > 0 else { return nil }
//
//    let rawNormal = CGPoint(x: -direction.y / length, y: direction.x / length)
//
//    // Smooth normal with previous normal to avoid jitter
//    let normal: CGPoint
//    if let prevNormal = previousNormal {
//      let blendedX = prevNormal.x * 0.75 + rawNormal.x * 0.25
//      let blendedY = prevNormal.y * 0.75 + rawNormal.y * 0.25
//      let blendedLength = hypot(blendedX, blendedY)
//      normal = CGPoint(x: blendedX / blendedLength, y: blendedY / blendedLength)
//    } else {
//      normal = rawNormal
//    }
//
//    let offset = CGPoint(x: normal.x * width / 2, y: normal.y * width / 2)
//
//    let result = (left: current + offset, right: current - offset, normal: normal)
//
//    /// An addition to address paths crossing etc, and causing artifacts
//    /// Compute the dot product to get the angle between the normals
//    if let prevNormal = previousNormal {
//      let dot = normal.x * prevNormal.x + normal.y * prevNormal.y
//      // If angle between normals is too sharp (dot close to -1), reduce width
//      guard dot < 0.1 else {
//        return result
//      }
//      let clampedWidth = width * 0.5
//      let offset = CGPoint(x: normal.x * clampedWidth / 2, y: normal.y * clampedWidth / 2)
//      return (left: current + offset, right: current - offset, normal: normal)
//    }
//
//    return result
//  }
//
//}
//
//// MARK: - Backups of functions that *may* have give the stroke fun/messy qualities
//extension VariableWidthPath {
//
//  /// This alternative seems less likely/able to turn the rotation of the
//  /// normals, to match the direction of movement, resulting in a 'flatter',
//  /// kinda calligraphic stroke, as if using a parallel pen
//  public mutating func addPointAlt(
//    to current: CGPoint,
//    rawWidth: CGFloat
//  ) {
//    if let pendingFirstPoint {
//      /// This is part of an ongoing stroke, not the first point
//      if let (left, right, _) = computeSmoothedOffset(from: pendingFirstPoint, to: current, width: rawWidth) {
//        leftEdge.append(left)
//        rightEdge.append(right)
//      }
//    } else {
//      /// This is the first point — assign an arbitrary
//      /// normal (e.g., horizontal)
//      let offset = CGPoint(x: rawWidth / 2, y: 0)
//      leftEdge.append(current - offset)
//      rightEdge.append(current + offset)
//    }
//  }
//}
