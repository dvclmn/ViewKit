//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers


extension Box {
  public enum FrameStyle: Sendable, Codable, Equatable {
    case single
    case double
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
