//
//  PartType+Flex.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import SwiftUI

extension Box.PartType {
  /// Whether or not this part should take on repeatable behaviour
  public enum Flexibility: Equatable, Codable {
    
    case repeatable(axis: Axis)
    case fixed
  }
}

//protocol Repeatable {
//  func repeated(to width: Int, along axis: Axis) -> Box.Part
//}

//extension Box.Part: Repeatable {
//  func repeated(to width: Int, along axis: Axis) -> Box.Part {
//    guard flexibility == .repeatable(axis: axis) else { return self }
//    // repeat glyphs horizontally or vertically
//  }
//}
