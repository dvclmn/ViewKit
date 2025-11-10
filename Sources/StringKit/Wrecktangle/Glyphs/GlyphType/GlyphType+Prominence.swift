//
//  GlyphType+Placement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

//public typealias Prominence = Box.GlyphProminence

extension Box.GlyphDescriptor {

  public struct Prominence: Sendable, Codable, Hashable {
    let x: ProminenceType
    let y: ProminenceType

    public init(
      x: ProminenceType = .standard,
      y: ProminenceType = .standard
    ) {
      self.x = x
      self.y = y
    }
  }

  /// Describes the visual weight / thickness of this glyph.
  /// Usually used in conjunction with location/placement, to
  /// create the desired effect, such as a bolder exterior
  /// structure, and lighter interior.
  public enum ProminenceType: String, Hashable, Sendable, Codable {
    case standard
    case increased
  }
}
extension Box.GlyphDescriptor.Prominence {
  public static let standard = Self(x: .standard, y: .standard)
  public static let increased = Self(x: .increased, y: .increased)
}
extension Box.GlyphDescriptor.Prominence: CustomStringConvertible {
  public var description: String {
    "Prominence[x: \(x.rawValue), y: \(y.rawValue)]"
  }
}
