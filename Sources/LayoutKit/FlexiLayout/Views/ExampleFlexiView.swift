//
//  ExampleFlexiView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 22/9/2025.
//

import BaseHelpers
import SwiftUI

//extension DummyContent.Animal: FlexiItem {}
//
//public struct ExampleFlexiView: View {
//
//  @State private var data = DummyContent.Animal.withSymbols()
//
//  public var body: some View {
//
//    VStack {
//      FlexiView(.list)
//      FlexiView(.grid)
//    }
//  }
//}

//extension ExampleFlexiView {
//
//  @ViewBuilder
//  func FlexiView(_ layoutMode: LayoutMode) -> some View {
//    FlexiLayoutView(
//      layoutMode: <#T##LayoutMode#>,
//      data: <#T##[FlexiItem]#>,
//      multiSelection: <#T##Binding<Set<Hashable>>?#>)
////    FlexiLayoutView(
////      layoutMode: layoutMode,
////      data: data,
////      selection: nil,
////      groupedBy: nil,
////      columns: .quickAdaptive(mode: .fill(min: 80, ))
////    ) { item in
//      if let item = data.first(where: { $0.id == item.id }) {
//
//        switch layoutMode {
//          case .grid:
//            MaybeLabel(item.label)
//              .frameWithAspectRatio(1.3)
//              .quickBackground()
//              
//
//          case .list:
//            MaybeLabel(item.label)
//        }
//      }
//    }
//  }
//}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  ExampleFlexiView()
//}
//#endif
