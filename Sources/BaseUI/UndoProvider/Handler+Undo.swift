//
//  Handler+Undo.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/10/2025.
//

// Full credit to Nil Coalescing for this undo approach
// https://github.com/NilCoalescing/SwiftUI-Code-Examples/tree/main/Undo-and-Redo

import SwiftUI

@MainActor
@Observable
final public class UndoHandler<Value> {

  var binding: Binding<Value>?
  weak var undoManger: UndoManager?

  func registerUndo(from oldValue: Value, to newValue: Value) {
    undoManger?.registerUndo(withTarget: self) { handler in
      handler.registerUndo(from: newValue, to: oldValue)
      handler.binding?.wrappedValue = oldValue
    }
  }

  init() {}
}
