//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

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
  public enum PartType: Hashable, Codable {
    case horizontal(HorizontalLocation = .top)
    case vertical(VerticalLocation = .leading)
    case join(Join)
    case corner(Corner)
    case blank

    public var flexibility: Flexibility {
      switch self {
        case .horizontal, .blank: .repeatable(axis: .horizontal)
        case .vertical: .repeatable(axis: .vertical)
        case .join, .corner: .fixed
      }
    }
  }  // END part type
}

extension Box.PartType {

  public enum HorizontalLocation: Hashable, Codable {
    case top
    case bottom
    case interior  // Aka Divider/Spacer
  }

  public enum VerticalLocation: Hashable, Sendable, Codable {
    case leading
    case trailing
    case interior  // Aka Divider
  }

  public enum LineSegment {
    case capLeading
    case capTrailing
  }

  /// Whether or not this part should take on repeatable behaviour
  public enum Flexibility: Equatable, Codable {
    case repeatable(axis: Axis)
    case fixed
  }

  public enum Corner: Hashable, Sendable, Codable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
  }
}
