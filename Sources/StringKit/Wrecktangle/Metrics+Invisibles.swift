//
//  Characters.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUI

extension Box {

  
  public enum Invisibles {
    case line
    case space
    case tab
    case padding
    case paddingAlt

    public enum LineType {
      case new
      case wrap
    }

    public var character: Character {
      switch self {
        case .line: "¬"  // ¶
        case .space: "/"
        case .tab: "→"
        case .padding: ","
        case .paddingAlt: "."
      }
    }
//    
//    public func paddingCharacter(for element: Invisibles) -> Character {
//      config.metrics.contains(.invisibles) ? element.character : " "
//    }

  }
}
