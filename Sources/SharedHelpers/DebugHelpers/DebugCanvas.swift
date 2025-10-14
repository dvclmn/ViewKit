//
//  DebugCanvas.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

public enum DebugPoint {
  case none
  case point(Color = .orange)
  
  var colourForPoint: Color? {
    switch self {
      case .point(let colour):
        return colour
      case .none:
        return nil
    }
  }
}

public enum DebugTextPosition {
  case aboveOrigin
  case belowOrigin
  
  var multiplierForYPosition: CGFloat {
    switch self {
      case .aboveOrigin:
        return 1
      case .belowOrigin:
        return -1
    }
  }
}

