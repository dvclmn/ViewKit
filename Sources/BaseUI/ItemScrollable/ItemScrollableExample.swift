//
//  ItemScrollableExample.swift
//  BaseComponents
//
//  Created by Dave Coleman on 26/5/2025.
//

// import BaseHelpers
import SwiftUI

//public struct ScrollableViewExample: View {
//
//  @State private var scrolledItem: ExampleTab = ExampleTab.sartim
//  @State private var scrolledTo: String?
//
//  public var body: some View {
//
//    HStack {
//
//      VStack {
//
//        Text("Vertical scrolling")
//          .font(.title2)
//          .foregroundStyle(.secondary)
//        Spacer()
//
//        HStack {
//
//          ItemScrollable(
//            scrolledItem: $scrolledItem,
//            axis: .vertical,
//            showsIndicators: false
//          ) { item in
//            Text(item.name)
//              .foregroundStyle(item == scrolledItem ? .blue : .primary)
//          }
//
//          .frame(width: 80, height: 140)
//
//          ItemScrollable(
//            scrolledItem: $scrolledItem,
//            axis: .vertical,
//            showsIndicators: false
//          ) { item in
//            Text(item.name)
//              .foregroundStyle(item == scrolledItem ? .blue : .primary)
//          }
//
//          .frame(width: 80, height: 400)
//
//          ItemScrollable(
//            scrolledItem: $scrolledItem,
//            axis: .vertical,
//            showsIndicators: false,
//            startingScrollAnchor: .center
//          ) { item in
//            Text(item.name)
//              .foregroundStyle(item == scrolledItem ? .blue : .primary)
//          }
//
//          .frame(width: 80, height: 200)
//        }
//
//        Spacer()
//
//      }  // END vstack
//      .frame(width: 400, height: 500)
//      .padding()
//      .background(.blue.quinary.opacity(0.3))
//
//      VStack {
//
//        Text("Horizontal scrolling")
//          .font(.title2)
//          .foregroundStyle(.secondary)
//
//        Spacer()
//
//        Button("Scroll to random") {
//          let random = Self.randomScrollItem()
//          scrolledItem = random
//          scrolledTo = random.name
//        }
//
//        ItemScrollable(
//          scrolledItem: $scrolledItem,
//          axis: .horizontal,
//          showsIndicators: false
//        ) { item in
//          Text(item.name)
//            .foregroundStyle(item == scrolledItem ? .blue : .primary)
//        }
//
//        .frame(width: 200, height: 40)
//        .padding(.bottom, 30)
//        .overlay(alignment: .bottom) {
//          if let scrolledTo {
//            Text("Scrolled to \(scrolledTo)")
//              .foregroundStyle(.tertiary)
//          }
//        }
//
//        ItemScrollable(
//          scrolledItem: $scrolledItem,
//          axis: .horizontal,
//          showsIndicators: false
//        ) { item in
//          Text(item.name)
//            .foregroundStyle(item == scrolledItem ? .blue : .primary)
//        }
//
//        .frame(width: 380, height: 40)
//
//        ItemScrollable(
//          scrolledItem: $scrolledItem,
//          axis: .horizontal,
//          showsIndicators: false,
//          startingScrollAnchor: .trailing
//        ) { item in
//          Text(item.name)
//            .foregroundStyle(item == scrolledItem ? .blue : .primary)
//        }
//
//        .frame(width: 260, height: 40)
//
//        Spacer()
//
//      }  // END vstack
//      .frame(width: 400, height: 500)
//      .padding()
//      .background(.black.secondary)
//    }
//    .frame(width: 800, height: 500)
//    .background(.black.secondary)
//
//  }
//
//  private static func randomScrollItem() -> ExampleTab {
//    let all = ExampleTab.allCases
//    return all.randomElement() ?? .sartim
//  }
//}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  ScrollableViewExample()
//}
//#endif
