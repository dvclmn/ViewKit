//
//  InfoBarInternalHoverView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 27/6/2025.
//

import BasePrimitives
import LayoutKit
import SwiftUI
import BaseTools
//import UIPrimitives

struct InfoBarSectionView: View {
  @Environment(\.sectionLabelDisplay) private var sectionLabelDisplay

  let sectionTitle: String
  let items: [InfoBarItem]

  private let sectionItemSpacing: CGFloat = Styles.sizeTiny

  var body: some View {

//    DecomposedView(.section, axis: .horizontal) {
      Section {
        /// This is the HStack (and spacing) between *whole* individual InfoBar Items.
        HStack(spacing: sectionItemSpacing) {
          ForEach(items) { item in
            InfoBarItemView(item: item)
          }
        }
        .labelStyle(.base)
        .iconColour(.secondary)
        .labelColour(.secondary)
        .labelIconSpacingCompatible(4)

      } header: {
        MaybeLabel(sectionTitle)
          .environment(\.labelDisplay, sectionLabelDisplay)
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
          .padding(.trailing, sectionItemSpacing)
      }

//    }
//    .containerValueBool(.hasSpacers, false)

    /// Controls Divider visibility between whole Sections
//    .containerValueBool(.hasDividers, false)
  }
}
