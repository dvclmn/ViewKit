//
//  ModifierIncrements.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/1/2026.
//

import Foundation

//public struct ModifierIncrementMapping: Sendable {
//  public let fine: Modifiers
//  public let medium: Modifiers
//  public let coarse: Modifiers
//
//  public static let standard = ModifierIncrementMapping(
//    fine: [],
//    medium: .shift,
//    coarse: .command
//  )
//
//  public func tier(for modifiers: Modifiers) -> IncrementGranularity {
//    if modifiers.contains(coarse) { return .coarse }
//    if modifiers.contains(medium) { return .medium }
//    return .fine
//  }
//}
//
//public struct NumericIncrements: Sendable {
//  public let steps: IncrementSteps
//  public let modifierMapping: ModifierIncrementMapping
//
//  public static let standard = NumericIncrements(
//    steps: .standard,
//    modifierMapping: .standard
//  )
//
//  public func stepSize(for modifiers: Modifiers) -> CGFloat {
//    let tier = modifierMapping.tier(for: modifiers)
//    return steps[tier]
//  }
//}

//
//
//public enum NumericIncrements {
//  case standard
//  case custom(Modifiers)
//}
//
//extension NumericIncrements {
//
//
//  func stepSize() -> CGFloat {
//    return {
//      if modifierKeys == .command {
//        100
//      } else if modifierKeys == .shift {
//        10
//      } else {
//        1
//      }
//    }()
//  }
//}
