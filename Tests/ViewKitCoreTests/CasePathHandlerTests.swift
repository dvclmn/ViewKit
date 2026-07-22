//
//  CasePathHandlerTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 22/7/2026.
//

import EnumMacros
import SwiftUI
import Testing
@testable import ViewKitCore

@Suite("CasePathHandler")
@MainActor
struct CasePathHandlerTests {

  @Test("shared meta bindings restore each case's last complete value")
  func sharedMetaBindingsRestoreLastCompleteValueForEachCase() {
    let store = SelectionStore(selection: .appearance(.lines))
    let selection = store.binding()
    let handler = CasePathHandler(initialValue: selection.wrappedValue)
    let toolbarSelection = handler.metaBinding(selection)
    let commandSelection = handler.metaBinding(selection)

    toolbarSelection.wrappedValue = .controls
    #expect(store.selection == .controls(.general))

    store.selection = .controls(.pan)
    commandSelection.wrappedValue = .appearance
    #expect(store.selection == .appearance(.lines))

    store.selection = .appearance(.dots)
    toolbarSelection.wrappedValue = .controls
    #expect(store.selection == .controls(.pan))

    commandSelection.wrappedValue = .appearance
    #expect(store.selection == .appearance(.dots))
  }
}

@MainActor
private final class SelectionStore {
  var selection: TestInspectorTab

  init(selection: TestInspectorTab) {
    self.selection = selection
  }

  func binding() -> Binding<TestInspectorTab> {
    Binding(
      get: { self.selection },
      set: { self.selection = $0 },
    )
  }
}

@MetaEnum
private enum TestInspectorTab: Equatable {
  case appearance(Appearance = .wave)
  case controls(Controls = .general)

  enum Appearance: Equatable {
    case wave
    case lines
    case dots
  }

  enum Controls: Equatable {
    case general
    case pan
  }
}
