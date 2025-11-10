//
//  GlyphType+Placement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

//public typealias Prominence = Box.GlyphProminence

extension Box {

  public struct GlyphProminence: Sendable, Codable, Hashable {
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
}
extension Box.GlyphProminence {
  
  /// Describes the visual weight / thickness of this glyph.
  /// Usually used in conjunction with location/placement, to
  /// create the desired effect, such as a bolder exterior
  /// structure, and lighter interior.
  public enum ProminenceType: String, Hashable, Sendable, Codable {
    case standard
    case increased
  }
  
  
}
extension Box.GlyphProminence {
  public static let standard = Self(x: .standard, y: .standard)
  public static let increased = Self(x: .increased, y: .increased)
}
extension Box.GlyphProminence: CustomStringConvertible {
  public var description: String {
    "Prominence[x: \(x.rawValue), y: \(y.rawValue)]"
  }
}
