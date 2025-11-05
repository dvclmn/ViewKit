//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers


extension Box {
  public enum FrameStyle: Sendable, Codable, Equatable {

    case single(
      frame: Box.GlyphProminence = .increased,
      dividers: Box.GlyphProminence = .standard
    )

    case double(
      exterior: Box.GlyphProminence = .increased,
      interior: Box.GlyphProminence = .standard
    )
    
    case notebook
  }
}

extension Box.FrameStyle {
  
  var reservedWidth: Int {
    switch self {
      case .single: 1
      case .double: 3
      case .notebook: 3
    }
  }
}
