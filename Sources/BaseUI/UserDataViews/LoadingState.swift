//
//  LoadingState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import CoreTools
import SwiftUI

public struct DataStoreView<Store: UserDataHandler, Content: View>: View {
  @Environment(\.undoManager) private var undoManager
  //  @State private var store: Store
  //  let dataState: LoadState<Store.Value>
  //  let setReady: () -> Void
  //  let store: Store
  @Bindable var store: Store
  let didUpdatUserData: (Store.Value) -> Void
  let content: Content

  public init(
    store: Store,
    didUpdatUserData: @escaping (Store.Value) -> Void,
    //    dataState: LoadState<Store.Value>,
    //    setReady: @escaping () -> Void,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.store = store
    self.didUpdatUserData = didUpdatUserData
    //    self._store = State(initialValue: store)
    //    self.dataState = dataState
    //    self.setReady = setReady
    self.content = content()
  }

  public var body: some View {
    switch store.dataState {
      case .idle, .loading:
        ProgressView("Loading…")
          .task {
            store.setReady(store.storage)
            //            setReady()
            //            store.setReady(store.storage)
            //            await store.hydrateFromStorage()
          }

      case .failed(let error):
        StateView("Error loading data", message: error.localizedDescription)
      //        popup?.showPopup("Error loading Wave data")
      //        ErrorView(error: error) {
      //          await store.hydrateFromStorage()
      //        }

      case .ready:
        content
          .environment(store)
          .task(id: store.userDataIfPresent) {
            store.userDataDidChange(updateStorage: didUpdatUserData)
            //            store.userDataDidChange { data in
            //              store.$storage.withLock { $0 = data }
            //            }
            //      stageConfigDidChange()
          }
          .task(id: undoManager) {
            store.undoManager = undoManager
          }
    //        Breathing_ContentView()
    //          .environment(store)
    //
    //          .toolbar {
    //            ToolbarItem {
    //              Toggle(
    //                isPaused.wrappedValue
    //                  ? "Paused"
    //                  : "Playing",
    //                isOn: isPaused.reversed
    //              )
    //            }
    //          }
    }
  }
}
