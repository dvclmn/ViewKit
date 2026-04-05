//
//  CellSelectionAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/3/2026.
//

/// Tap + Command on a Cell will toggle it between selected and deselected.
/// Conversely, Drag + Command will *add* to a selection only, not subtract.
/// For Dragging, Option is the modifier to remove from a selection.
///
/// - Tap + Command => Toggle
/// - Drag + Command => Add
/// - Drag + Option => Subtract
/// - Tap + Option => Subtract (single-item remove)
/// - No modifiers => New (replace)

//public struct CellSelectionAction {
//  let kind: SelectionKind
//  let modifiers: Modifiers
//
//  public init(kind: SelectionKind, modifiers: Modifiers) {
//    self.kind = kind
//    self.modifiers = modifiers
//  }
//}
//
//extension CellSelectionAction {
//
//  public var selectionMode: CellSelectionMode {
//    switch kind {
//      case .single:
//        if modifiers.isCommandOnly { return .toggle }
//        if modifiers.isOptionOnly { return .subtract }
//        return .new
//
//      case .multiple:
//        if modifiers.isCommandOnly { return .add }
//        if modifiers.isOptionOnly { return .subtract }
//        return .new
//    }
//  }
//}
