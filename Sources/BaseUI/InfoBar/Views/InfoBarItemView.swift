//
//  HBarItemView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/6/2025.
//

import CoreTools
import SwiftUI
import ViewKitCore
import ViewTools

public struct InfoBarItemView: View {
  @Environment(\.itemLabelDisplay) private var itemLabelDisplay
  @Environment(\.isDebugMode) private var isDebugMode
  let item: InfoBarItem

  public var body: some View {

    /// This is the spacing between the HBar Item Icon, and
    /// the HBar item content. When set to display Icon-only,
    /// the `item.content` can deceptively look like the
    /// Label text, but it is not, it is seperate.
    ///
    /// Spacing for Label {space} Content
    HStack(spacing: Styles.sizeSmall) {
      if let label = item.label {
        QuickLabel(label)
          .environment(\.labelDisplay, itemLabelDisplay)

          /// This seems to be behaving; this ensures that the text label
          /// from MaybeLabel doesn't get truncated
          .fixedSize(horizontal: true, vertical: false)
          .foregroundStyle(.tertiary)
        //          .debugFrame("Label", .purple, isEnabled: isDebugMode)
      }

      Text(item.resolvedContent)

        /// Taking the edge off the brightness
        .opacity(0.9)
        .monospacedDigit()
        .fixedSize(horizontal: true, vertical: false)
        .debugFrame("Value", colour: .brown, isEnabled: isDebugMode)

      Divider().opacity(0.6)
        /// Adds breathing room between the end of the content and its trailing Divider
//        .padding(.leading, Styles.sizeSmall)
    }
    /// Some leading padding here brings the icon in from the edge a bit,
    /// including the very first item
    //    .padding(.leading, Styles.sizeTiny)

  }
}
