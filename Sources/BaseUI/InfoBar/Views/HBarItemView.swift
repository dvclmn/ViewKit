//
//  HBarItemView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/6/2025.
//


import SwiftUI
import SharedHelpers

public struct InfoBarItemView: View {
  @Environment(\.isShowingSectionHeader) private var isShowingSectionHeader
  @State private var isHoveringItem: Bool = false

  let item: InfoBarItem

  public var body: some View {

    /// This is the spacing between the HBar Item Icon, and
    /// the HBar item content. When set to display Icon-only,
    /// the `item.content` can deceptively look like the
    /// Label text, but it is not, it is seperate.
    HStack(spacing: Styles.sizeMicro) {
      MaybeLabel(item.label)

      Text(item.content)
    }

    .onHover { hovering in
      isHoveringItem = hovering
    }
    .containerValueBool(.isShowingSectionHeader, isShowingSectionHeader)
    .containerValueBool(.hasDividers, true)
    .containerValueBool(.hasSpacers, false)

  }
}
