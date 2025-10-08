//
//  GridStyleModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 23/9/2025.
//

import SwiftUI
import BaseUI

import SharedHelpers

public struct GridStyleModifier: ViewModifier {

  public func body(content: Content) -> some View {
    RoundedRectangle(cornerRadius: Styles.sizeSmall)
      .fill(AnyShapeStyle(.quinary).opacity(0.8))
      .aspectRatio(1.2, contentMode: .fit)
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
      )
      .overlay {
        content
          .labelStyle(.base)
          .lineLimit(2)
          .multilineTextAlignment(.center)
          .font(.system(size: 14))
          .padding(Styles.sizeSmall)
//          .environment(\.symbolVariant, .fill)
          .environment(\.iconFontSize, 22)
          .environment(\.iconColour, AnyShapeStyle(.tertiary))
        //          .symbolRenderingMode(.hierarchical)
        //        SearchItemView(match: item)
        //          .font(.title2)
      }
  }
}
