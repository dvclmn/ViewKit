//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import EnumMacros
import SharedHelpers
import SwiftUI

extension Box {

  /// A `PartType` is a *composition* of `GlyphType`s.
  /// See ``Box/GlyphType``. `PartType` describes a
  /// stack of multiple Characters, and a `GlyphType`
  /// describes a *single* character.
  ///
  /// See ``Box/GlyphStack``, the output type for `PartType`
  ///
  /// Example:
  /// ```
  /// // A 3x2 Corner
  /// ┏━━
  /// ┃ ┌
  ///
  ///
  /// // A 3x1 Trailing Join
  /// ┤ ║
  ///
  /// ```
  /// Note: these are not  visual/styling presets.
  /// They are more from the fabrication perspective.
  /// This many by this many, or something.
  ///
  /// No 'this fun glyph', and this one, and so on.
  @CaseDetection
  public enum PartType: Hashable, Codable, Sendable {
    case horizontal(HorizontalLocation)
    case vertical(VerticalLocation)
    case join(Box.JoinType)
    case corner(Box.CornerType)
    case blank

    /// Describes whether this Part be repeated dynamically
    /// along a given Axis. Or whether it is single-use, in a
    /// specific location in a structure.
    ///
    /// In future, I think the code should establish how
    /// long the repeatable `Part` is (along the relevant axis),
    /// and thus how the fitting should be calculated, given
    /// the available box width/height.
    public var flexibility: Flexibility {
      switch self {
        case .horizontal, .blank: .repeatable(axis: .horizontal)
        //        case .vertical: .repeatable(axis: .vertical)
        case .join, .corner, .vertical: .fixed
      //        case .join, .corner, .text: .fixed
      }
    }
  }  // END part type
}

extension Box.PartType {

  var name: String {
    switch self {
      case .horizontal(let loc): "horizontal/\(loc.rawValue)"
      case .vertical(let loc): "vertical/\(loc.rawValue)"
      case .join(let joinType): "join/\(joinType.rawValue)"
      case .corner(let cornerType): "corner/\(cornerType.rawValue)"
      //      case .text(let string): "text/\(string.truncate(to: 16))"
      case .blank: "blank"
    }

  }

  /// This introduces the concept of *valid orientation*;
  /// for the top of a Box, the Part must be constructed with
  /// the strong glyph at the top, and the light glyph at the bottom,
  /// according to the intent of the Theme.
  ///
  /// For the bottom of a frame, the light is top, and the strong
  /// is bottom, and so on for walls etc.
  ///
  /// For example, a Theme may define a double-walled frame
  /// with contrasting weights for each wall character, like the below,
  /// where the top is strong, and the 'interior' is lighter.
  ///
  /// ```
  ///   ━━━━
  ///   ────
  ///
  /// ```
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

  //  public enum LineSegment {
  //    case capLeading
  //    case capTrailing
  //  }

}

extension Box {
  public enum CornerType: String, Hashable, Sendable, Codable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
  }

  /// Describes where the joining takes place
  public enum JoinType: String, Hashable, Sendable, Codable {
    case leading  // ┠
    case trailing  // ┨
    case top  // ┯
    case bottom  // ┷
    case cross  // ╂
  }

}

extension Box.PartType: CustomStringConvertible {
  public var description: String {
    return "Part/\(name)"
  }
}
