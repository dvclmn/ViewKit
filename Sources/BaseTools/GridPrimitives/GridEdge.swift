//
//  Model+GridEdge.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/7/2025.
//

import SwiftUI


public enum GridEdge: String, Sendable, Codable, Equatable, Hashable, CaseIterable {
  case top
  case trailing
  case bottom
  case leading

  public var isRowEdge: Bool { self == .top || self == .bottom }
  public var isColumnEdge: Bool { self == .leading || self == .trailing }

  public var name: String { rawValue.capitalized }

  public init?(fromBoundaryPoint point: GridBoundaryPoint) {
    guard let edge = point.gridEdge else { return nil }
    self = edge
  }

  public var gridBoundaryPoint: GridBoundaryPoint {
    let point = GridBoundaryPoint(fromEdge: self)
    return point
  }

  public var geometryAxis: GeometryAxis {
    switch self {
      case .top, .bottom: .vertical
      case .leading, .trailing: .horizontal
    }
  }
}

extension GridEdge {
  public struct Set: OptionSet, Sendable {
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    public let rawValue: Int

    public static let top = Self(rawValue: 1 << 0)
    public static let trailing = Self(rawValue: 1 << 1)
    public static let bottom = Self(rawValue: 1 << 2)
    public static let leading = Self(rawValue: 1 << 3)
    public static let all: Self = [.top, .trailing, .bottom, .leading]
  }
}

extension GridEdge.Set {
  public init(_ edge: GridEdge) {
    switch edge {
      case .top: self = .top
      case .trailing: self = .trailing
      case .bottom: self = .bottom
      case .leading: self = .leading
    }
  }

  public var names: String {
    GridEdge.allCases
      .filter { contains(Self($0)) }
      .map(\.name)
      .joined(separator: ", ")
  }
}

extension GridEdge {

  /// The coordinate delta for moving in this direction
  public var directionVector: (column: Int, row: Int) {
    switch self {
      case .top: return (column: 0, row: -1)
      case .bottom: return (column: 0, row: 1)
      case .leading: return (column: -1, row: 0)
      case .trailing: return (column: 1, row: 0)
    }
  }

  public func path(in rect: CGRect) -> Path {
    let (start, end) = rect.edgePoints(for: self)
    return Path {
      $0.move(to: start)
      $0.addLine(to: end)
    }
  }

}

extension CGRect {
  public func edgePoints(for edge: GridEdge) -> (start: CGPoint, end: CGPoint) {
    switch edge {
      case .top: (CGPoint(x: minX, y: minY), CGPoint(x: maxX, y: minY))
      case .bottom: (CGPoint(x: minX, y: maxY), CGPoint(x: maxX, y: maxY))
      case .leading: (CGPoint(x: minX, y: minY), CGPoint(x: minX, y: maxY))
      case .trailing: (CGPoint(x: maxX, y: minY), CGPoint(x: maxX, y: maxY))
    }
  }
}
