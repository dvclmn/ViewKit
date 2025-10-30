//
//  Characters.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUI

public extension Box {
  
  func paddingCharacter(for element: Invisibles) -> Character {
    guard config.metrics.contains(.invisibles) else { return " " }
    return element.character
  }
  
  enum Invisibles {
    case line
    case space
    case tab
    case padding
    case paddingAlt
    
    public enum LineType {
      case new
      case end
    }
    
    public var character: Character {
      switch self {
        case .line: "¬" // ¶
        case .space: "/"
        case .tab: "→"
        case .padding: ","
        case .paddingAlt: "."
      }
    }
  }
}
