//
//  ColumnTypeItem.swift
//  SumBuddy
//
//  Created by Dave Coleman on 24/10/2025.
//

/// Borrowed from SumBuddy's Column Type Picker, in case it's useful


//import IdentifiedCollections
//import SwiftUI
//// import ToolKit
//
//public struct ColumnTypeItem: View {
//  @Environment(AppHandler.self) private var store
//  @Environment(\.table) private var table
//  @Environment(\.headerState) private var headerState
//  @Environment(\.headerID) private var headerID
//
//  @State private var isHovering: Bool = false
//  private let angleVariance: CGFloat = 3.7
//
//  let type: ColumnType
//
//  public var body: some View {
//
//    Button {
////      store.changeColumnType(to: type, headerID: headerID, for: &table.wrappedValue)
//      guard let id = headerID else { return }
//      table.wrappedValue.perform(.updateColumnType(id, type))
//      headerState.presented.wrappedValue = nil
//      
//    } label: {
//      TableIcon(type.label)
////      TableIcon(for: .header(type))
//        .offset(y: isHovering ? -2.1 : 0)
//        .animation(.easeOut(duration: 0.055), value: isHovering)
//
//        .rotationEffect(iconAngle)
//        .animation(.snappy(duration: 0.38, extraBounce: 0.54), value: iconAngle)
//
//        //        .tooltip(
//        //          type.name,
//        //          offset: .zero,
//        //          alignment: .center,
//        //          isShowingForDebug: false
//        //        )
//        .labelStyle(.iconOnly)
//        .padding(headerState.wrappedValue.hitAreaBuffer)
//        .contentShape(.rect)
//        .themeColour(\.primary)
//    }
//
//    .transition(
//      .asymmetric(
//        insertion: .offset(x: -10, y: 0).combined(with: .opacity),
//        removal: .opacity
//      )
//    )
//    //    .transition(.push(from: .leading).animation(Styles.animationSpringQuickNBouncy))
//
//    .buttonStyle(.plain)
//
//    .environment(\.iconColour, isHovering ? AnyShapeStyle(.primary) : AnyShapeStyle(.secondary))
//    .onHover { hover in
//      isHovering = hover
//    }
//  }
//}
//extension ColumnTypeItem {
//  private var iconAngle: Angle {
//    isHovering
//      ? Double.random(in: -angleVariance...angleVariance).toAngle
//      : .zero
//  }
//}
