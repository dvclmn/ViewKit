//
//  Model+InteractionRules.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/7/2025.
//

import BasePrimitives
import SwiftUI

public struct InteractionHandler {

  /// Important: There is a difference between handling the
  /// current active interaction, and handling which interactions
  /// are allowed to be initiated at any given time.
  var current: Interaction? = nil

  /// This forces the caller to define which is allowed.
  /// If not defined, none will work.
  public var allowed: InteractionKind = .none
  public var keysHeld: Keys = []
  public var modifiersHeld: Modifiers = []

  let keysToWatch: Set<KeyEquivalent> = [.space]
}

