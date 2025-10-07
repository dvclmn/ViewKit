//
//  InfoBarInternalHoverView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 27/6/2025.
//

import BaseUI
import BaseHelpers
import SwiftUI

struct InfoBarSectionView: View {
  @Environment(\.sectionLabelDisplay) private var sectionLabelDisplay

  let sectionTitle: String
  let items: [InfoBarItem]

  var body: some View {

    DecomposedView(.section, axis: .horizontal) {
      Section {
        HStack {
          ForEach(items) { item in
            InfoBarItemView(item: item)
              .environment(\.labelDisplay, .iconOnly)
          }
        }
        .padding(.horizontal, Styles.sizeSmall)

        .labelStyle(.custom)

      } header: {
        MaybeLabel(sectionTitle)
          .fontWeight(.semibold)
          .frame(maxHeight: .infinity)
          .padding(.horizontal, Styles.sizeTiny.bump)
          .background(.black.opacity(0.4))
          .overlay(alignment: .trailing) {
            Rectangle()
              .fill(.white.opacity(0.07))
              .frame(width: 1)
              .frame(maxHeight: .infinity)
          }
      }
    }
    .containerValueBool(.hasSpacers, false)
  }
}
