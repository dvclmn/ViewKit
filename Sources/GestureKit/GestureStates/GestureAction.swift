//
//  GestureAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import CoreTools
import SwiftUI

/// Derived
public enum TransformInteraction {
  case zoom(delta: CGFloat)
  case pan(delta: CGSize)
  case rotate(delta: Angle)
}

//public protocol GestureAction: Sendable {
//  associatedtype Value  // E.g. CGSize for pan
//  var value: Value { get set }
//  var kind: InteractionKind.Meta { get }
//
//  /// A value for 'at rest'
//  static var initial: Self { get }
//  mutating func update(_ newValue: Value)
//}

//public struct PointerState {
//  var action: PointerAction = .none
//  var location: CGPoint?
//  var dragRect: CGRect?
//}
//
//public enum PointerAction {
//  case tap
//  case drag
//  case hover
//  case none
//}
