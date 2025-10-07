//
//  ItemLabelView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/5/2025.
//

import BaseUI
import BaseHelpers
import SwiftUI

public struct ItemLabelView<Item: FuzzySearchable>: View {
  @Environment(\.isEmphasised) private var isEmphasised
  @Environment(\.layoutMode) private var layoutMode

  let item: Item
  let fuzzyRanges: FuzzyRanges?
  let isHovering: Bool

  public var body: some View {

    if let layoutMode {
      VStack(alignment: .leading) {
        MaybeLabel(item.styledLabel(ranges: fuzzyRanges, with: .highlighter))
        //      Text(styledItemText(with: searchHighlightStyle))
        //      Text(styledItemText(with: searchHighlightStyle))
          .font(layoutMode.isGrid ? .callout.weight(.medium) : .title3)
          .multilineTextAlignment(layoutMode.isGrid ? .center : .leading)
          .lineLimit(2)
          .scaleEffect(isHovering ? titleScaleEffect : 1.0)
          .foregroundStyle(foregroundColour)
        //        .padding(.top, Styles.sizeRegular)
        
        if showsDescription, let blurb = item.blurb {
          Text(blurb)
            .font(.callout)
            .foregroundStyle(.tertiary)
            .lineLimit(2, reservesSpace: true)
        }
      }  // END vstack      
    }

  }
}

extension ItemLabelView {

  var foregroundColour: Color {
    return isEmphasised ? Color.primary : .secondary
  }

  public var titleScaleEffect: CGFloat {
    switch layoutMode {
      case .grid: 0.98
      case .list: 1.0
      case .none: 1.0
    }
  }

  public var showsDescription: Bool {
    switch layoutMode {
      case .grid: false
      case .list: true
      case .none: false
    }
  }

  var searchHighlightStyle: AttributeContainer {
    var container = AttributeContainer()
    container.backgroundColor = Color.white.opacity(0.15)
    container.foregroundColor = Color.primary

    return container
  }

}
