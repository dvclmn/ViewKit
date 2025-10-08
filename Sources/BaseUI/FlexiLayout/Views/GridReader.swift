//
//  GridReader.swift
//  BaseComponents
//
//  Created by Dave Coleman on 2/10/2025.
//


//import SwiftUI

/// The idea here is that there's no noise from the Environment values,
/// that's all calculated at the caller, and then I suppose we can then
/// use this reliable `GridConfig` to derive column count,
/// frames for each item, etc?
//extension Flexi {

//public enum GridReader<Content, Item>
//where Item: Sendable & Identifiable & Equatable, Item.ID: Hashable & Sendable, Content: View {}

/// What is this view responsible for?
///
/// - Knows how many columns the grid view has (even when adaptive!)
/// - Knows the overall content size (even when larger or smaller than vis scroll rect)
/// - Knows the item frames
/// - Maybe even somehow knows how to navigate from one item to another directionally
//public struct GridReader<Content: View, Item: Sendable & Identifiable & Equatable>: View {
//  
//  @State private var gridContext: GridContext<Item>
//
//  let config: GridConfig
//  let pinnedViews: PinnedScrollableViews
//  let content: (GridContext<Item>) -> Content
//
//  public init(
//    data: [Item],
//    config: GridConfig,
//    pinnedViews: PinnedScrollableViews,
//    @ViewBuilder content: @escaping (GridContext<Item>) -> Content
//  ) {
//    
//    let context = GridContext(
//      data: data,
//      itemSpacing: config.spacingItem
//    )
//    self._gridContext = State(initialValue: context)
//    self.config = config
//    self.pinnedViews = pinnedViews
//    self.content = content
//  }
//
//  public var body: some View {
//
//    LazyVGrid(
//      columns: config.columns,
//      alignment: config.alignmentGrid,
//      spacing: config.spacingGrid,
//      pinnedViews: [.sectionHeaders]
//    ) {
//      content(gridContext)
//        
//    }
//    .debugTextOverlay(debugText, alignment: .topLeading)
////    .viewSize(mode: .debounce(0.2)) { geometry in
////      gridContext.viewSize =
////    }
//  }
//}
////}
//
//extension GridReader {
//
////  private var context: GridContext<Item> {
////
////  }
//
//  private var debugText: String {
//    """
//    Column count: \(gridContext?.itemWidth?.displayString ?? "nil")
//    """
//  }
//}
