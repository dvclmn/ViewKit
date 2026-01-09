//
//  Flexi+Grid+Item.swift
//  BaseComponents
//
//  Created by Dave Coleman on 2/10/2025.
//

import SharedHelpers
import SwiftUI
import LayoutKit


extension Flexi {
  public struct GridItem: View {
    @Environment(FlexiHandler<Item>.self) private var store
    @Environment(GridHandler.self) private var gridHandler
    @Environment(\.selectionMode) private var selectionMode
    @Environment(\.isFocusable) private var isFocusable

    let item: Item
    let focused: FocusState<Flexi.GridFocus?>.Binding
    let content: (Item) -> Content

    public var body: some View {

      ZStack {
        content(item)
          .id(item.id)
          .viewSize(capture: .frameInScrollView, mode: .debounce()) { frame in
            updateIfChanged(&gridHandler.itemFrames[item.id], to: frame)
          }
        //          .overlay {
        //            Text("Width: \(gridHandler.itemFrames[item.id]?.width ?? 0)")
        //          }
      }
      .focusable(isFocusable)
      .focused(focused, equals: .item(item.id))
      .focusEffectDisabled()

      .onMoveCommand { direction in
        print("Pressed move: \(direction) on item: \(item)")
      }
      .onKeyPress(.return, phases: .down) { keyPress in
        print("Pressed return: \(keyPress) on item: \(item)")
        if let selectionMode, selectionMode.isMulti {
          store.multiSelection = [item.id]
        }
        return .handled
      }

    }
  }
}
