import CoreTools
import Foundation
import Observation
import SwiftUI
import Testing
@testable import ViewKitCore

@Suite("UserDataHandler")
struct UserDataHandlerTests {

  @Test("setReady publishes a working value without changing storage")
  @MainActor
  func setReadyPublishesWorkingValueWithoutChangingStorage() {
    let stored = SampleUserData(title: "Stored", count: 1)
    let working = SampleUserData(title: "Working", count: 2)
    let store = SampleUserDataStore(storage: stored)

    store.setReady(working)

    #expect(store.userDataIfPresent == working)
    #expect(store.storage == stored)
    #expect(store.isReady)
  }

  @Test("setValue mutates the ready value but leaves persistence explicit")
  @MainActor
  func setValueMutatesReadyValueButLeavesPersistenceExplicit() {
    let stored = SampleUserData(title: "Stored", count: 1)
    let store = SampleUserDataStore(storage: stored, state: .ready(stored))

    store.setValue(\.title, to: "Changed")

    #expect(store.userDataIfPresent?.title == "Changed")
    #expect(store.storage == stored)
  }

  @Test("dataBinding writes through the update pipeline")
  @MainActor
  func dataBindingWritesThroughUpdatePipeline() {
    let stored = SampleUserData(title: "Stored", count: 1)
    let replacement = SampleUserData(title: "Replacement", count: 3)
    let store = SampleUserDataStore(storage: stored, state: .ready(stored))

    store.dataBinding().wrappedValue = replacement

    #expect(store.userDataIfPresent == replacement)
    #expect(store.storage == stored)
  }

  @Test("userDataDidChange debounces ready-value persistence")
  @MainActor
  func userDataDidChangeDebouncesReadyValuePersistence() async throws {
    let stored = SampleUserData(title: "Stored", count: 1)
    let working = SampleUserData(title: "Working", count: 2)
    let store = SampleUserDataStore(
      storage: stored,
      state: .ready(working),
      debounceInterval: 0.01
    )

    store.userDataDidChange { value in
      store.storage = value
    }
    try await Task.sleep(for: .milliseconds(40))

    #expect(store.storage == working)
  }

  @Test("withUndo registers an undo operation for the working value")
  @MainActor
  func withUndoRegistersUndoForWorkingValue() {
    let stored = SampleUserData(title: "Stored", count: 1)
    let store = SampleUserDataStore(storage: stored, state: .ready(stored))
    let undoManager = UndoManager()
    store.undoManager = undoManager

    store.setValue(action: .withUndo(action: "Rename"), \.title, to: "Changed")
    undoManager.undo()

    #expect(store.userDataIfPresent == stored)
  }
}

private struct SampleUserData: Equatable, Sendable {
  var title: String
  var count: Int
}

@MainActor
@Observable
private final class SampleUserDataStore: UserDataHandler {
  var dataState: UserDataState<SampleUserData>
  var storage: SampleUserData
  var undoManager: UndoManager?
  let debouncer: AsyncDebouncer

  required init(state: UserDataState<SampleUserData>) {
    self.dataState = state
    self.storage = state.readyValue ?? SampleUserData(title: "", count: 0)
    self.debouncer = AsyncDebouncer(interval: 0.01)
  }

  init(
    storage: SampleUserData,
    state: UserDataState<SampleUserData> = .idle,
    debounceInterval: TimeInterval = 0.2
  ) {
    self.dataState = state
    self.storage = storage
    self.debouncer = AsyncDebouncer(interval: debounceInterval)
  }
}
