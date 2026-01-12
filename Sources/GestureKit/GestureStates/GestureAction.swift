//
//  GestureAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import CoreTools
import SwiftUI

public protocol GestureAction: Sendable {
  associatedtype Value  // E.g. CGSize for pan
  var value: Value { get set }
  var kind: InteractionKind.Meta { get }

  /// A value for 'at rest'
  static var initial: Self { get }
  mutating func update(_ newValue: Value)
}

public protocol CanvasState {
  var zoom: CGFloat { get set }
  var pan: CGSize { get set }
  var rotation: Angle { get set }
  
  var tapLocation: CGPoint? { get set }
  var hoverLocation: CGPoint? { get set }
}

enum TransformInteraction {
  case pan(CGSize)
  case zoom(CGFloat)
  case rotate(Angle)
}


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
