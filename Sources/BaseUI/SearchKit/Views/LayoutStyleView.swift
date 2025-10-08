//
//  Results+ListView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/5/2025.
//




import SwiftUI

//public struct LayoutStyleView<Content: View>: View {
//  @Environment(\.isCompactMode) private var isCompactMode
//
//  let layout: QuickSearchLayout
//  @ViewBuilder let content: Content
//
//  public var body: some View {
//
//    ScrollView(.vertical, showsIndicators: false) {
//      switch layout {
//        case .grid:
//          LazyVGrid(
//            columns: columns,
//            alignment: .center,
//            spacing: Styles.sizeRegular
//          ) {
//            content
//              .aspectRatio(1.2, contentMode: .fill)
//          }
//        case .list:
//          VStack(spacing: 0) {
//            content
//          }  // END vstack
//      }  // END switch
//    }  // END scrollview
//  }
//}
//
//extension LayoutStyleView {
//  private var columns: [GridItem] {
//    let columns: [GridItem] = Array(
//      repeating: GridItem(
//        .flexible(minimum: 90, maximum: .infinity),
//        spacing: Styles.sizeRegular
//      ),
//      count: isCompactMode ? 2 : 3
//    )
//    return columns
//  }
//}
