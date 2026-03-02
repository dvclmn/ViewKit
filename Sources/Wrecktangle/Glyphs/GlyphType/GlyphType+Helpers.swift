//
//  Descriptor+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

/// Helpful note:
/// For structure, we're usually talking about Role and Weight.
/// For the below helpers, the Role is actually expressed in the
/// function name, like `h()` (horizontal is the Role), and the
/// Weight is in the signature.
extension Box.GlyphStructure {

  static func h(_ weight: Box.GlyphWeight = .standard) -> Self {
    Self(.horizontal, weight: weight)
  }

  static func v(_ weight: Box.GlyphWeight = .standard) -> Self {
    Self(.vertical, weight: weight)
  }

  /// No need to pass in `GlyphRole` here. This is handled
  /// conveniently in the FrameBuilder, where `PartRole` is
  /// passed through, and converted to `GlyphRole`.
  static func join(
    x: Box.GlyphWeight.WeightType = .standard,
    y: Box.GlyphWeight.WeightType = .standard
  ) -> Self {
    guard case .join(let joinType)? = Box.PartStructure.Context.currentRole else {
      fatalError("join(x:y:) used outside a join Part")
    }
    return Self(.join(joinType), x: x, y: y)
  }

  static func corner(_ weight: Box.GlyphWeight = .standard) -> Self {
    guard case .corner(let cornerType)? = Box.PartStructure.Context.currentRole else {
      fatalError("corner(_:) used outside a corner Part")
    }
    return Self(.corner(cornerType), weight: weight)
  }

  static var blank: Self {
    Self(.blank, weight: .standard)
  }
}
