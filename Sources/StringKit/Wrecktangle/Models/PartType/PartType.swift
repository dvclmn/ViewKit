//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import SwiftUI
import SharedHelpers

extension Box {

  public enum PartType: Hashable, Codable {

    case horizontal(HorizontalLocation = .top)
    case vertical(VerticalLocation = .leading)
    case join(Join)
    case corner(Corner)
    case blank

    public var flexibility: PartFlexibility {
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
  public enum PartFlexibility: Equatable, Codable {
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
