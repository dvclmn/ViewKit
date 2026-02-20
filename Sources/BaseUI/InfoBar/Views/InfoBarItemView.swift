//
//  HBarItemView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/6/2025.
//

import BasePrimitives
import SwiftUI

public struct InfoBarItemView: View {
  @Environment(\.isShowingSectionHeader) private var isShowingSectionHeader
  @Environment(\.itemLabelDisplay) private var itemLabelDisplay

  @State private var isHoveringItem: Bool = false

  let item: InfoBarItem

  public var body: some View {

    /// This is the spacing between the HBar Item Icon, and
    /// the HBar item content. When set to display Icon-only,
    /// the `item.content` can deceptively look like the
    /// Label text, but it is not, it is seperate.
    HStack(spacing: Styles.sizeTiny) {
      if let label = item.label {
        MaybeLabel(label)
          .environment(\.labelDisplay, itemLabelDisplay)
          /// Some leading padding here brings the icon in from the edge a bit,
          /// including the very first item
          .padding(.leading, Styles.sizeTiny)
          /// This seems to be behaving; this ensures that the text label
          /// from MaybeLabel doesn't get truncated
          .fixedSize(horizontal: true, vertical: false)
      }

      Text(String(describing: item.content))
        /// Taking the edge off the brightness
        .opacity(0.9)
        .monospacedDigit()
        .fixedSize(horizontal: true, vertical: false)

      Divider().opacity(0.6)
        /// Adds breathing room between the end of the content and its trailing Divider
        .padding(.leading, Styles.sizeNano)
    }

    .onHover { hovering in
      isHoveringItem = hovering
    }
    .containerValueBool(.isShowingSectionHeader, isShowingSectionHeader)
    .containerValueBool(.hasDividers, true)
    .containerValueBool(.hasSpacers, false)

  }
}
