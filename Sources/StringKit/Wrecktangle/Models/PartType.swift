//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import SwiftUI

extension BoxPart {

  public enum PartType: Hashable {

    case horizontal(HorizontalLocation = .top)
    case vertical(VerticalLocation = .leading)
    case join(Join)
    case corner(Corner)

    public var flexibility: PartFlexibility {
      switch self {
        case .horizontal:
          .repeatable(axis: .horizontal)

        case .vertical:
          .repeatable(axis: .vertical)

        default:
          .fixed
      }
    }
  }  // END part type

}

extension BoxPart {

  public enum HorizontalLocation: Hashable {
    case top
    case bottom
    case interior  // Aka Divider
  }

  public enum VerticalLocation: Hashable, Sendable {
    case leading
    case trailing
    case interior  // Aka Divider
  }

  public enum LineSegment {
    case capLeading
    case capTrailing
  }

  public enum PartFlexibility: Equatable {
    case repeatable(axis: Axis)
    case fixed
  }

  public enum Join: Hashable, Sendable {
    case leading
    case trailing
    case top
    case bottom
    case cross
  }

  public enum Corner: Hashable, Sendable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
  }
}
