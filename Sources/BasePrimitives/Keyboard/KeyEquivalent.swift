//
//  KeyEquivalent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/7/2025.
//

import SwiftUI

extension Set where Element == KeyEquivalent {
  public var isHoldingSpace: Bool {
    self.contains(.space)
  }
}

/// See `Modifiers` for similar name/icon properties for modifiers
extension KeyEquivalent {

  public func name(isAbbreviated: Bool = false) -> String {
    return isAbbreviated ? name.abbreviated : name.full
  }
  
  public var nameFull: String { name.full }
  public var nameAbbreviated: String { name.abbreviated }

  private var name: (full: String, abbreviated: String) {
    switch self {
      case .clear: ("Clear", "Clear")
      case .delete: ("Delete", "Del")
      case .deleteForward: ("Delete Forward", "Del Fwd")
      case .upArrow: ("Up Arrow", "Up")
      case .downArrow: ("Down Arrow", "Down")
      case .leftArrow: ("Left Arrow", "Left")
      case .rightArrow: ("Right Arrow", "Right")
      case .escape: ("Escape", "Esc")
      case .home: ("Home", "Home")
      case .end: ("End", "End")
      case .pageUp: ("Page Up", "PgUp")
      case .pageDown: ("Page Down", "PgDown")
      case .`return`: ("Return", "Return")
      case .space: ("Space", "Space")
      case .tab: ("Tab", "Tab")
      case .init(character): ("Character: \(character)", "\(character)")
      default: ("Unknown", "Unknown")
    }
  }

  public var symbolLiteral: Character {
    switch self {
      case .clear: "􀆄"
      case .delete: "􁂈"
      case .deleteForward: "􁂒"
      case .upArrow: "􀄤"
      case .downArrow: "􀄥"
      case .leftArrow: "􀄦"
      case .rightArrow: "􀰇"
      case .escape: "􀆧"
      case .home: "􀰹"
      case .end: "􀱈"
      case .pageUp: "􀅃"
      case .pageDown: "􀅄"
      case .`return`: "􀅇"
      case .space: "􁁺"
      case .tab: "􁂎"
      case .init(character): character
      default: "?"
    }
  }

  public var symbolCapitalised: String {
    String(symbolLiteral).capitalized
  }
}
