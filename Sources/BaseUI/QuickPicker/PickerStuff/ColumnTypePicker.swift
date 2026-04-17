//
//  ColumnTypePicker.swift
//  SumBuddy
//
//  Created by Dave Coleman on 21/10/2025.
//

/// Borrowed from SumBuddy's Column Type Picker, in case it's useful

//
//import IdentifiedCollections
//import SwiftUI
//// import BaseTools

//public struct ColumnTypePicker: View {
//  @Environment(AppHandler.self) private var store
//  @Environment(\.table) private var table
//  @Environment(\.headerState) private var headerState
//  @Environment(\.headerID) private var headerID
//  @Environment(\.columnType) private var columnType
//  @Environment(\.unitSize) private var unitSize
//
//  @FocusState var focused: TableFocus?
////  let alignment: HorizontalAlignment
//
//  public var body: some View {
//
//    @Bindable var store = store
//
//    HStack(spacing: unitSize.gridLength(1, along: .horizontal) ?? 0) {
//      ForEach(Array(typeList.enumerated()), id: \.element.id) { index, colType in
//        VPack {
//          if isPresented {
//            ColumnTypeItem(type: colType)
//          }
//        }
//        .frameFromGridLength(axis: .horizontal, length: 2, alignment: .topLeading)
//
//        .animation(
//          .snappy(duration: 0.16, extraBounce: 0.3).delay(Double(index) * 0.02),
//          value: isPresented
//        )
//
//      }  // END foreach
//    }
//    .focusable()
//    .focusEffectDisabled()
////    .focused($focused, equals: .columnTypePicker(headerID))
//
//    .onExitCommand {
//      print("Pressed exit command")
//      headerState.presented.wrappedValue = nil
//      store.focused = nil
//    }
//
//    .offset(
//      x: -headerState.wrappedValue.hitAreaBuffer,
//      y: -headerState.wrappedValue.hitAreaBuffer
//    )
//    .gridPadding(.leading, 3)
//
//    .onAppear {
//      focused = .columnTypePicker(headerID)
//    }
//
//    .bindModel($store.focused, to: $focused)
//
//  }
//}
//
//extension ColumnTypePicker {
//
//  private var isPresented: Bool {
//    headerState.wrappedValue.isPresented(for: headerID)
//  }
//
//  private var typeList: [ColumnType] {
//    let all = ColumnType.allCases
//    let current = columnType
//
//    return all.filter { $0 != current }
//  }
//}
