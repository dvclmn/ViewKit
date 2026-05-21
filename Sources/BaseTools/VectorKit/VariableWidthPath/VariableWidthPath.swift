//
//  VariableWidthPath.swift
//  Lilypad
//

import SwiftUI

/// Builds a filled `Path` representing a stroke with per-point width variation.
///
/// Feed points one at a time via ``addPoint(to:rawWidth:)``, then call
/// ``generatePath(usesSmoothCurves:)`` to get a filled SwiftUI `Path`.
///
/// ## How it works
///
/// At each point, a perpendicular normal is computed from the direction of
/// travel. The point is offset left and right by `width / 2` along that
/// normal, building two parallel edge arrays. The final path traces the
/// left edge forward, then the right edge backward, forming a closed outline.
///
/// Normal smoothing (75/25 blend with the previous normal) prevents
/// jitter on slightly noisy input. Sharp direction changes are handled by
/// reducing width at the corner to avoid crossing edges.
///
/// For a flatter, more calligraphic stroke, use ``NormalStrategy/calligraphic``.
/// This keeps the stroke edges parallel to a fixed normal instead of rotating
/// them with the direction of travel.
///
/// ## Usage
///
/// ```swift
/// var vwp = VariableWidthPath()
/// for point in denseSampledPoints {
///   vwp.addPoint(to: point.position, rawWidth: brushStyle.width(for: point.speed))
/// }
/// let path = vwp.generatePath(usesSmoothCurves: true)
/// context.fill(path, with: .color(colour))
/// ```
///
public struct VariableWidthPath {
  var leftEdge: [CGPoint] = []
  var rightEdge: [CGPoint] = []

  private let normalStrategy: NormalStrategy
  private let widthSmoothing: CGFloat

  private var pendingFirstPoint: CGPoint?
  private var pendingFirstWidth: CGFloat?
  private var previousSpinePoint: CGPoint?
  private var previousNormal: CGPoint?
  private var previousWidth: CGFloat?

  /// - Parameters:
  ///   - normalStrategy: Strategy used to derive outline normals.
  ///   - widthSmoothing: Blend amount applied to the previous width. Use `0`
  ///     when widths are already deliberate, such as from ``PathWidthProfile``.
  public init(
    normalStrategy: NormalStrategy = .rotating,
    widthSmoothing: CGFloat = 0.85,
  ) {
    self.normalStrategy = normalStrategy
    self.widthSmoothing = min(max(0, widthSmoothing), 1)
  }
}

extension VariableWidthPath {

  /// Controls how stroke normals are derived from incoming points.
  public enum NormalStrategy {
    /// Rotate the normal with the current direction of travel, smoothing
    /// changes against the previous normal to reduce input jitter.
    case rotating

    /// Use one fixed normal for every point. This produces a flatter,
    /// calligraphic mark, similar to a parallel pen.
    case fixed(CGPoint)

    public static var calligraphic: Self { .fixed(CGPoint(x: 1, y: 0)) }
  }
}

extension VariableWidthPath {

  /// Append a point to the stroke outline with the given width.
  ///
  /// Width is smoothed against the previous value (85/15 blend) to avoid
  /// sudden jumps from noisy velocity readings.
  public mutating func addPoint(to current: CGPoint, rawWidth: CGFloat) {
    let width = smoothedWidth(for: rawWidth)
    previousWidth = width

    guard let previous = previousSpinePoint else {
      pendingFirstPoint = current
      pendingFirstWidth = width
      previousSpinePoint = current
      return
    }

    guard let (left, right, normal) = offsetEdges(from: previous, to: current, width: width) else {
      return
    }

    if leftEdge.isEmpty, let pendingFirstPoint {
      let firstWidth = pendingFirstWidth ?? width
      let firstEdges = offsetEdges(at: pendingFirstPoint, width: firstWidth, normal: normal)
      leftEdge.append(firstEdges.left)
      rightEdge.append(firstEdges.right)
      self.pendingFirstPoint = nil
      pendingFirstWidth = nil
    }

    leftEdge.append(left)
    rightEdge.append(right)
    previousNormal = normal
    previousSpinePoint = current
  }

  private func smoothedWidth(for rawWidth: CGFloat) -> CGFloat {
    let positiveWidth = max(0, rawWidth)
    if let previousWidth {
      return previousWidth * widthSmoothing + positiveWidth * (1 - widthSmoothing)
    }
    return positiveWidth
  }

  private func offsetEdges(
    at point: CGPoint,
    width: CGFloat,
    normal: CGPoint,
  ) -> (left: CGPoint, right: CGPoint) {
    let half = width / 2
    return (
      left: CGPoint(x: point.x + normal.x * half, y: point.y + normal.y * half),
      right: CGPoint(x: point.x - normal.x * half, y: point.y - normal.y * half),
    )
  }
}

// MARK: - Path generation

extension VariableWidthPath {

  /// Generates the final filled `Path` from the accumulated edge points.
  ///
  /// - Parameter usesSmoothCurves: When `true`, edges are drawn with
  ///   quadratic curves through midpoints for a smoother silhouette.
  ///   When `false`, straight line segments are used (faster, fine for
  ///   high-density input).
  public func generatePath(usesSmoothCurves: Bool = true) -> Path {
    guard leftEdge.count == rightEdge.count, !leftEdge.isEmpty else {
      return fallbackPath
    }

    var path = Path()
    if usesSmoothCurves {
      buildSmoothPath(&path)
    } else {
      buildLinePath(&path)
    }
    return path
  }

  private var fallbackPath: Path {
    var path = Path()
    if let point = pendingFirstPoint {
      let diameter = max(1, pendingFirstWidth ?? previousWidth ?? 1)
      path.addEllipse(
        in: CGRect(
          x: point.x - diameter / 2,
          y: point.y - diameter / 2,
          width: diameter,
          height: diameter,
        ))
    } else if let pt = leftEdge.first ?? rightEdge.first {
      path.addEllipse(in: CGRect(x: pt.x - 1, y: pt.y - 1, width: 2, height: 2))
    }
    return path
  }

  private func buildLinePath(_ path: inout Path) {
    path.move(to: leftEdge[0])
    for pt in leftEdge.dropFirst() { path.addLine(to: pt) }
    for pt in rightEdge.reversed() { path.addLine(to: pt) }
    path.closeSubpath()
  }

  private func buildSmoothPath(_ path: inout Path) {
    // Left edge, forward.
    path.move(to: leftEdge[0])
    for i in 1..<leftEdge.count {
      let mid = CGPoint(
        x: (leftEdge[i - 1].x + leftEdge[i].x) / 2,
        y: (leftEdge[i - 1].y + leftEdge[i].y) / 2,
      )
      path.addQuadCurve(to: mid, control: leftEdge[i - 1])
    }
    path.addLine(to: leftEdge.last!)

    // Right edge, reverse.
    path.addLine(to: rightEdge.last!)
    for i in (1..<rightEdge.count).reversed() {
      let mid = CGPoint(
        x: (rightEdge[i].x + rightEdge[i - 1].x) / 2,
        y: (rightEdge[i].y + rightEdge[i - 1].y) / 2,
      )
      path.addQuadCurve(to: mid, control: rightEdge[i])
    }
    path.addLine(to: rightEdge[0])
    path.closeSubpath()
  }

  /// Computes the left and right edge points for the segment from `from` to
  /// `current`, with normal smoothing and sharp-corner width reduction.
  private mutating func offsetEdges(
    from: CGPoint,
    to current: CGPoint,
    width: CGFloat,
  ) -> (left: CGPoint, right: CGPoint, normal: CGPoint)? {
    let dx = current.x - from.x
    let dy = current.y - from.y
    let len = hypot(dx, dy)
    guard len > 0 else { return nil }

    let rawNormal = CGPoint(x: -dy / len, y: dx / len)
    let normal = normal(for: rawNormal)

    let effectiveWidth: CGFloat
    if let prev = previousNormal {
      let dot = normal.x * prev.x + normal.y * prev.y
      effectiveWidth = dot < 0.1 ? width * 0.5 : width
    } else {
      effectiveWidth = width
    }

    let edges = offsetEdges(at: current, width: effectiveWidth, normal: normal)
    return (
      left: edges.left,
      right: edges.right,
      normal: normal,
    )
  }

  private func normal(for rawNormal: CGPoint) -> CGPoint {
    switch normalStrategy {
      case .rotating:
        guard let previousNormal else { return rawNormal }

        let bx = previousNormal.x * 0.75 + rawNormal.x * 0.25
        let by = previousNormal.y * 0.75 + rawNormal.y * 0.25
        let length = hypot(bx, by)
        guard length > 0.0001 else { return rawNormal }
        return CGPoint(x: bx / length, y: by / length)

      case .fixed(let fixedNormal):
        let length = hypot(fixedNormal.x, fixedNormal.y)
        guard length > 0.0001 else { return rawNormal }
        return CGPoint(x: fixedNormal.x / length, y: fixedNormal.y / length)
    }
  }
}
