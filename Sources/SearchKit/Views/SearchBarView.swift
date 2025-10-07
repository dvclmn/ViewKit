//
//  SearchBarView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/5/2025.
//

import BaseHelpers
import BaseUI

import SwiftUI

//public struct SearchBarView<Item: QuickSearchItem>: ToolbarContent {
//  @Environment(QuickSearchHandler<Item>.self) private var store
//
//  private let customControlGroupHeight: CGFloat = 32
//
//  let onItemTap: (Item.ID) -> Void
//
//  public var body: some ToolbarContent {
//
//    @Bindable var store = store
//
////    VStack {
////      HStack {
//    
//    ToolbarItem {
//      TextField("Search...", text: $store.searchQuery)
//        .textFieldStyle(OverViewSearch())
//        .setExplicitHeight(store.searchBarHeight)
//      #warning("Need to bring keyboard stuff back")
////        .onSubmit {
////          if let keySelected = store.keySelectedItem {
////            onItemTap(keySelected.id)
////          }
////        }
//      
//    }
//    ToolbarItem {
//      Cycler(item: store.layoutBinding) { item in
//        MaybeLabel(item.label)
//      }
//      .environment(\.labelDisplay, .iconOnly)
//      //          .setLabelDisplay(.iconOnly)
//      //          .buttonStyle(.custom(.capsule))
//      .environment(\.explicitHeight, customControlGroupHeight)
//      //          .setExplicitHeight(customControlGroupHeight)
//      .setAspectRatio(1)
//      //          .setIsSquare(true, length: customControlGroupHeight)
//      .environment(\.strokeColour, AnyShapeStyle(Color.gray.opacity(0.25)))
//      //          .setStroke(style: AnyShapeStyle(.gray.opacity(0.25)))
//      //          .setStrokeConfig(Color.gray.opacity(0.25))
//      
//    }
////      }
//
////    }
//
//  }
//}
//
//public struct OverViewSearch: @preconcurrency TextFieldStyle {
////  @Environment(\.layoutConfig) private var layout
//  @Environment(\.cornerRounding) private var cornerRounding
//  @Environment(\.explicitHeight) private var explicitHeight
//
//  @FocusState var isFocused: Bool
//
//  @MainActor public func _body(configuration: TextField<Self._Label>) -> some View {
//    configuration
//      .focusable()
//      .focused($isFocused)
//      .onAppear {
//        isFocused = true
//      }
//      .textFieldStyle(.plain)
//      .font(.title2)
//      .frame(height: explicitHeight ?? 36)
//      .multilineTextAlignment(.leading)
//  }
//}
