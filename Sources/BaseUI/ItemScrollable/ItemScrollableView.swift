//
//  ItemScrollableView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/5/2025.
//

import LayoutKit
import SharedHelpers
import SwiftUI

public struct ItemScrollable<Content: View, Item: Pickable & Shortcuttable>: View {
  //  @Environment(\.strokeConfig) private var strokeConfig
  //  @Environment(\.labelConfig) private var labelForeground
  //  @Environment(\.isItemSelected) private var isItemSelected
  //  @Environment(\.explicitHeight) private var explicitHeight

  //  @State private var contentWidth: CGFloat? = nil
  private let contentPaddingH: CGFloat = Styles.sizeSmall

  /// This assumes a default scroll target of `start`
  //  @State private var scrollLocation: ScrollLocation = .start

  @Binding var scrolledItem: Item
  let items: [Item]
  let axis: Axis
  let showsIndicators: Bool
  let startingScrollAnchor: UnitPoint
  let maskFalloffLength: CGFloat
  let content: (Item) -> Content

  public init(
    scrolledItem: Binding<Item>,
    /// If no data is supplied here, `AllCases` is used
    items: [Item]? = nil,
    axis: Axis = .vertical,
    showsIndicators: Bool = true,
    maskFalloffLength: CGFloat = 26,
    startingScrollAnchor: UnitPoint = .topLeading,
    @ViewBuilder content: @escaping (Item) -> Content
  ) {
    self._scrolledItem = scrolledItem
    self.items = items ?? Array(Item.allCases)
    self.axis = axis
    self.showsIndicators = showsIndicators
    self.startingScrollAnchor = startingScrollAnchor
    self.maskFalloffLength = maskFalloffLength
    self.content = content
  }

  public var body: some View {

    ScrollViewReader { proxy in
      ScrollView(axis.toAxisSet, showsIndicators: showsIndicators) {
        DynamicStack(
          axis: axis,
          spacing: Styles.sizeMicro
        ) {
          ForEach(items) { item in
            OptionalShortcutView(item.keyboardShortcut) {
              ItemButton(scrolledItem: $scrolledItem, item: item, content: content)
            }
          }  // END forach
        }  // END dynamic layout
        .scrollTargetLayout()
        //        .viewSize(mode: .debounce(0.2)) { size in
        //          contentWidth = size.width
        //        }
      }  // END scroll view
      .defaultScrollAnchor(startingScrollAnchor)
      //      .scrollTargetBehavior(.viewAligned)
      .safeAreaPadding(.horizontal, contentPaddingH)
      .task(id: scrolledItem) {
        proxy.scrollTo(scrolledItem.id)
      }
    }  // END scroll view reader
    //    .frame(maxWidth: scrollviewWidth)
    .scrollMask(
      axis: axis,
      fallOffLength: maskFalloffLength,
      //      scrollLocation: scrollLocation
    )
    .quickBackground(shape: .capsule)
    //    .getScrollLocation(
    //      axis: axis
    //    ) { state in
    //      scrollLocation = state
    //    }

  }
}
