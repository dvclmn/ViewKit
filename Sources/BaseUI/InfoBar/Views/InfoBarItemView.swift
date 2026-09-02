//
//  HBarItemView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/6/2025.
//

import CoreTools
import StringTools
import SwiftUI
import ViewKitCore
import ViewTools

extension InfoBarView {
  struct ItemView: View {
    @Environment(\.itemLabelDisplay) private var itemLabelDisplay
    @Environment(\.isDebugMode) private var isDebugMode
    
    let item: InfoBarItem

    public var body: some View {

      // This is the spacing between the item label, and
      // the item content. When set to display Icon-only,
      // the content can deceptively appear to be the
      // text component of the label, but it is not.
      //
      // Layout: Label (icon + text) {space} Content (text)
      HStack(spacing: Styles.sizeSmall) {
        if let label = item.label {
          QuickLabel(label)
            .environment(\.labelDisplay, itemLabelDisplay)

            // This seems to be behaving; this ensures that the text label
            // from QuickLabel doesn't get truncated
            .fixedSize(horizontal: true, vertical: false)
            .foregroundStyle(.tertiary)
            .debugFrame(
//              "Label",
              colour: .purple,
              isEnabled: isDebugMode
            )
        }

        contentView
        // Taking the edge off the brightness
        .opacity(0.9)
        .debugFrame(
//          "Value",
          colour: .brown,
          isEnabled: isDebugMode
        )

        Divider().opacity(0.6)
        // Adds breathing room between the end of the content and its trailing Divider
        //        .padding(.leading, Styles.sizeSmall)
      }
      // Some leading padding here brings the icon in from the edge a bit,
      // including the very first item
      //    .padding(.leading, Styles.sizeTiny)

    }

    @ViewBuilder
    private var contentView: some View {
      switch item.content.width {
        case .intrinsic:
          Text(item.content.sourceContent)

        case .fixed, .flexible:
          TextColumns(
            item.content.resolvedColumnCount,
            alignment: item.content.alignment.swiftUIAlignment,
          ) {
            Text(item.content.sourceContent)
          }
          .fixedSize(horizontal: true, vertical: false)
      }
    }
  }
}

extension TextPadAlignment {
  fileprivate var swiftUIAlignment: Alignment {
    switch self {
      case .leading: .leading
      case .centre: .center
      case .trailing: .trailing
    }
  }
}
