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

/// This row is the observation boundary for one registration. Updating its content
/// doesn't require `InfoBarView` to recompute section discovery or ordering.
extension InfoBarView {
  struct ItemListView: View {
    let registration: InfoBarRegistration

    var body: some View {
      switch registration.content {
        case .items(let items):
          ForEach(items) { item in
            ItemView(item: item)
          }
      }
    }
  }
}

extension InfoBarView {
  struct ItemView: View {
    @Environment(\.itemLabelDisplay) private var itemLabelDisplay
    @Environment(\.isDebugMode) private var isDebugMode
    let item: InfoBarItem

    public var body: some View {

      // This is the spacing between the HBar Item Icon, and
      // the HBar item content. When set to display Icon-only,
      // the `item.content` can deceptively look like the
      // Label text, but it is not, it is seperate.
      //
      // Spacing for Label {space} Content
      HStack(spacing: Styles.sizeSmall) {
        if let label = item.label {
          QuickLabel(label)
            .environment(\.labelDisplay, itemLabelDisplay)

            // This seems to be behaving; this ensures that the text label
            // from QuickLabel doesn't get truncated
            .fixedSize(horizontal: true, vertical: false)
            .foregroundStyle(.tertiary)
            .debugFrame("Label", colour: .purple, isEnabled: isDebugMode)
        }

        TextColumns(
          item.content.resolvedColumnCount,
          alignment: item.content.alignment.swiftUIAlignment,
        ) {
          Text(item.content.sourceContent)
        }
        // Taking the edge off the brightness
        .opacity(0.9)
        .fixedSize(horizontal: true, vertical: false)
        .debugFrame("Value", colour: .brown, isEnabled: isDebugMode)

        Divider().opacity(0.6)
        // Adds breathing room between the end of the content and its trailing Divider
        //        .padding(.leading, Styles.sizeSmall)
      }
      // Some leading padding here brings the icon in from the edge a bit,
      // including the very first item
      //    .padding(.leading, Styles.sizeTiny)

    }
  }
}

private extension TextPadAlignment {
  var swiftUIAlignment: Alignment {
    switch self {
      case .leading: .leading
      case .centre: .center
      case .trailing: .trailing
    }
  }
}
