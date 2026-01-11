//
//  Model+Mode.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//

import SwiftUI
import BasePrimitives

/// Example interactions:
/// - Select / multi-select
/// - Drag to Resize
/// - Draw
/// - Pan/Zoom/Rotate canvas
public struct Interaction {
  let kind: InteractionKind
  let phase: InteractionPhase
  let modifiers: Modifiers?
}
