//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

//import EnumMacros
import BasePrimitives
import SwiftUI

extension Box {

  /// The counterpart to `GlyphRole`. Describes where a Part
  /// is used, in the stucture of a Box
//  @CaseDetection
  public enum PartRole: Hashable, Codable, Sendable {
    case horizontal(HorizontalLocation)
    case vertical(VerticalLocation)
    case join(Box.JoinType)
    case corner(Box.CornerType)
    case blank
  }
}

extension Box.PartRole {
  public enum HorizontalLocation: String, Hashable, Codable, Sendable {
    case top
    case bottom
    case interior  // Aka Divider/Spacer
  }

  public enum VerticalLocation: String, Hashable, Sendable, Codable {
    case leading
    case trailing
    case interior  // Aka Divider/Spacer
  }
}

extension Box {
  public enum CornerType: String, Hashable, Sendable, Codable, CaseIterable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
  }

  /// Describes where the joining takes place
  public enum JoinType: String, Hashable, Sendable, Codable, CaseIterable {
    case leading  // ┠
    case trailing  // ┨
    case top  // ┯
    case bottom  // ┷
    case cross  // ╂
  }
}

extension Box.CornerType {
  var name: String { rawValue.capitalized }
}
extension Box.JoinType {
  var name: String { rawValue.capitalized }
}

extension Box.PartRole {
  var name: String {
    switch self {
      case .horizontal(let loc): "horizontal/\(loc.rawValue)"
      case .vertical(let loc): "vertical/\(loc.rawValue)"
      case .join(let joinType): "join/\(joinType.name)"
      case .corner(let cornerType): "corner/\(cornerType.name)"
      case .blank: "blank"
    }
  }
}

extension Box.PartRole: PrettyPrintable {
  public func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    self.name
  }
}

extension Box.PartRole: CustomStringConvertible {
  public var description: String {
    return "Part/\(name)"
  }
}
