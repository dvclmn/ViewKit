//
//  Model+ListDirection.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/5/2025.
//

//import BaseHelpers
//import SwiftUI

#warning("Perhaps this is useful. But have turned off for now, as not using, and has compiler errors.")

//enum ListDirection: String {
//  case up
//  case down
//
//  func navigate<T: Identifiable>(
//    in searchResults: [FuzzyMatch<T>],
//    currentID: T.ID?
//  ) -> T.ID? {
//    let items = searchResults.map(\.item)
//    let currentIndex = items.firstIndex { $0.id == currentID }
//    let navigator = ListNavigator(items: items, currentIndex: currentIndex)
//
//    switch self {
//      case .up:
//        return navigator.previousIndex().flatMap { navigator.id(at: $0) }
//      case .down:
//        return navigator.nextIndex().flatMap { navigator.id(at: $0) }
//    }
//  }
//
//  static func fromKeyEquivalent(_ key: KeyEquivalent) -> Self? {
//    switch key {
//      case .upArrow: return .up
//      case .downArrow: return .down
//      default: return nil
//    }
//  }
//}
//
//public enum ListPosition {
//  case first
//  case middle
//  case last
//
//  public func rounding(_ roundingAmount: CGFloat = Styles.sizeSmall) -> RectangleCornerRadii {
//    switch self {
//      case .first:
//        .init(
//          topLeading: roundingAmount,
//          bottomLeading: .zero,
//          bottomTrailing: .zero,
//          topTrailing: roundingAmount
//        )
//      case .middle:
//        .init(
//          topLeading: .zero,
//          bottomLeading: .zero,
//          bottomTrailing: .zero,
//          topTrailing: .zero
//        )
//      case .last:
//        .init(
//          topLeading: .zero,
//          bottomLeading: roundingAmount,
//          bottomTrailing: roundingAmount,
//          topTrailing: .zero
//        )
//    }
//  }
//}
