//
//  Descriptor+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphType {

  static func fromRole(
    _ role: Box.GlyphRole,
    weight: Prominence = .standard,
    design: Design? = nil
  ) -> Self {
    let resolvedDesign = design ?? GlyphDesignContext.currentDesign ?? .sharp
    return .init(role, weight: weight, design: resolvedDesign)
  }

  func withoutStyle() -> Box.GlyphType {
    var copy = self
    /// or `.none`?
    copy.design = .sharp
    return copy
  }

  static func h(
    _ weight: Prominence = .standard,
    _ design: Design = .sharp
  ) -> Self {
    Self(.horizontal, weight: weight, design: design)
  }

  static func v(
    _ weight: Prominence = .standard,
    _ design: Design = .sharp
  ) -> Self {
    Self(.vertical, weight: weight, design: design)
  }

  static func join(
    x: ProminenceType = .standard,
    y: ProminenceType = .standard,
    _ design: Design = .sharp
  ) -> Self {
    guard case .join(let joinType)? = Box.PartContext.currentType else {
      fatalError("join(x:y:) used outside a join Part")
    }
    return Self(.join(joinType), x: x, y: y, design: design)
  }

  static func corner(
    _ weight: Prominence = .standard,
    _ design: Design = .sharp
  ) -> Self {
    guard case .corner(let cornerType)? = Box.PartContext.currentType else {
      fatalError("corner(_:) used outside a corner Part")
    }
    //          return .corner(prominence, type: cornerType)
    return Self(.corner(cornerType), weight: .standard, design: design)
  }

  static var blank: Self {
    Self(.blank, weight: .standard, design: .sharp)
  }
}
