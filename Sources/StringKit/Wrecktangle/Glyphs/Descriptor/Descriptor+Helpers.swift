//
//  Descriptor+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphDescriptor {

  func withoutStyle() -> Box.GlyphDescriptor {
    var copy = self
    /// or `.none`?
    copy.style = .sharp
    return copy
  }

  static func h(
    _ weight: Prominence = .standard,
    _ style: Style = .sharp
  ) -> Self {
    Self(.horizontal, weight, style)
  }

  static func v(
    _ weight: Prominence = .standard,
    _ style: Style = .sharp
  ) -> Self {
    Self(.vertical, weight, style)
  }

  #warning("Join and Corner need prominence?")
  static func join(
    _ type: Box.JoinType,
    _ style: Style = .sharp
  ) -> Self {
    guard case .join(let joinType)? = PartContext.currentType else {
      fatalError("join(x:y:) used outside a join Part")
    }
    return Self(.join(joinType), .standard, style)
  }

  static func corner(
    _ type: Box.CornerType,
    _ style: Style = .sharp
  ) -> Self {
    guard case .corner(let cornerType)? = PartContext.currentType else {
            fatalError("corner(_:) used outside a corner Part")
          }
//          return .corner(prominence, type: cornerType)
    return Self(.corner(cornerType), .standard, style)
  }

  static var blank: Self {
    Self(.blank, .standard, .sharp)
  }
}
