//
//  PointerAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/1/2026.
//

import Foundation

public protocol InteractionState: Sendable, Equatable {
  associatedtype Value
  var isActive: Bool { get }
}

public protocol PhasicInteraction: InteractionState {
  var phase: InteractionPhase { get set }
}

