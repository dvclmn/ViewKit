//
//  SearchItemView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/5/2025.
//

import BaseComponents
import BaseHelpers
import SwiftUI
import SharedHelpers

public struct SearchItemView<Item: FuzzySearchable>: View {
  @Environment(\.layoutMode) private var layoutMode
  @Environment(\.layoutAxis) private var layoutAxis
  @State private var isHovering: Bool = false

  let item: Item
  let fuzzyRanges: FuzzyRanges?

  public init?(
    match: FuzzyMatch<Item>,
  ) {
    self.item = match.item
    self.fuzzyRanges = match.ranges
  }

  public var body: some View {

    MaybeLabel(
      item.styledLabel(
        ranges: fuzzyRanges,
        with: .colours(Color.primary, on: .yellow.opacityMid)
      )
    )
    
    //    .foregroundStyle(.secondary.opacity(0.8))
    /// This offset is not animated, and is purely for optical alignment
    //    .offset(y: -Styles.sizeMicro)
    .padding(.vertical, paddingVertical)
    //    .padding(.top, paddingTop)
    //    .padding(.bottom, paddingBottom)
    //    .padding(.horizontal, layoutMode.isGrid ? Styles.sizeSmall.bump : Styles.sizeRegular)
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: (layoutMode?.isGrid ?? false) ? .center : .leading
    )
    .animation(Styles.animationSpringExtraQuick, value: isHovering)
    .onHover { hovering in
      isHovering = hovering
    }
  }
}

extension SearchItemView {

  private var paddingVertical: CGFloat {
    switch layoutMode {
      case .list: Styles.sizeSmall
      case .grid: Styles.sizeSmall
      case .none: Styles.sizeSmall
    }
  }

  //  var overallOffset: CGFloat {
  //    guard layoutMode.isGrid else { return .zero }
  //    return isHovering ? -1 : 0
  //  }

  //  var isFirst: Bool { listPosition == .first }
  //  var isLast: Bool { listPosition == .last }
  //
  //  var paddingTop: CGFloat {
  //    guard !layoutMode.isGrid else {
  //      return .zero
  //    }
  //    return isFirst ? Styles.sizeRegular : Styles.sizeSmall.bump
  //  }
  //  var paddingBottom: CGFloat {
  //    guard !layoutMode.isGrid else {
  //      return .zero
  //    }
  //    return isLast ? Styles.sizeRegular : Styles.sizeSmall.bump
  //  }
}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  SearchItemView<CoolItem>(
//    fuzzyMatch: FuzzyMatch<CoolItem>(
//      item: CoolItem.fraction,
//      score: 0,
//      ranges: []
//    ),
//    listPosition: .first
//  )
////  .environment(QuickSearchHandler<CoolItem>(collection: Array(CoolItem.allCases)))
//}
//#endif
