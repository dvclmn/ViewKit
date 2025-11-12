//
//  GlyphType+Placement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

//public typealias Prominence = Box.GlyphProminence

extension Box {

  public struct GlyphWeight: Sendable, Codable, Hashable {
    let x: WeightType
    let y: WeightType

    public init(
      x: WeightType = .standard,
      y: WeightType = .standard
    ) {
      self.x = x
      self.y = y
    }
  }
}

extension Box.GlyphWeight {

  /// Guards against weight 'data loss'
  func merged(with other: Self) -> Self {
    Box.GlyphWeight(
      x: x.merged(with: other.x),
      y: y.merged(with: other.y)
    )
  }

  /// Describes the visual weight / thickness of this glyph.
  /// Usually used in conjunction with location/placement, to
  /// create the desired effect, such as a bolder exterior
  /// structure, and lighter interior.
  public enum WeightType: String, Hashable, Sendable, Codable {
    case standard
    case increased
  }
}

extension Box.GlyphWeight.WeightType {
  func merged(with other: Self) -> Self {
    /// Escalate to .increased if either side is increased
    return .standard
//    return .increased
//    (self == .increased || other == .increased) ? .increased : .standard
  }
}

extension Box.GlyphWeight {
  public static let standard = Self(x: .standard, y: .standard)
  public static let increased = Self(x: .increased, y: .increased)
}
extension Box.GlyphWeight: CustomStringConvertible {
  public var description: String {
    "Prominence[x: \(x.rawValue), y: \(y.rawValue)]"
  }
}
