//
//  UndoProvider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/10/2025.
//

// Full credit to Nil Coalescing for this undo approach
// https://github.com/NilCoalescing/SwiftUI-Code-Examples/tree/main/Undo-and-Redo
// https://nilcoalescing.com/blog/HandlingUndoAndRedoInSwiftUI/

import SwiftUI

/// Note: Editable text inputs in SwiftUI already automatically handle undo/redo
/// so don't wrap the bindings they use with this decorator.
public struct UndoProvider<WrappedView, Value>: View where WrappedView: View {
  @Environment(\.undoManager) var undoManager

  @State var handler: UndoHandler<Value> = UndoHandler()

  var binding: Binding<Value>
  let wrappedView: (Binding<Value>) -> WrappedView

  public init(
    _ binding: Binding<Value>,
    @ViewBuilder wrappedView: @escaping (Binding<Value>) -> WrappedView
  ) {
    self.binding = binding
    self.wrappedView = wrappedView
  }

  public var body: some View {

    wrappedView(self.interceptedBinding)

      .onAppear {
        self.handler.binding = self.binding
      }

      .task(id: self.undoManager) {
        self.handler.undoManger = self.undoManager
      }
  }
}

extension UndoProvider {
  var interceptedBinding: Binding<Value> {
    Binding {
      self.binding.wrappedValue
    } set: { newValue in
      self.handler.registerUndo(from: self.binding.wrappedValue, to: newValue)
      self.binding.wrappedValue = newValue
    }
  }
}
