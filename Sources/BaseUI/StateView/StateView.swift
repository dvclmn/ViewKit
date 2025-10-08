//
//  File.swift
//
//
//  Created by Dave Coleman on 27/5/2024.
//

import SwiftUI
import StringShared

public struct StateView<Content: View>: View {
  @Environment(\.layoutAxis) private var layoutAxis
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.isCompactMode) private var isCompact
  @Environment(\.iconFontSize) private var iconFontSize
  @Environment(\.controlSize) private var controlSize

  let label: QuickLabel
  let message: String?
  //  let iconSize: CGFloat
  let additionalContent: Content

  public var body: some View {

    VStack(
      alignment: layoutAlignment?.horizontal ?? .center,
      spacing: scale(16, for: controlSize, min: 6)
    ) {

      TextView()
        /// Pan gesture view was causing `FeatureIconView` to take
        /// up too much space, so using overlay to keep it contained better
        .overlay(alignment: .top) {
          IconView()
        }
        /// Padding to achieve nice vertical optical centering
        .safeAreaPadding(.top, label.icon != nil ? scale(iconSize * 1.4, for: controlSize) : .zero)

      // MARK: - Message
      MessageView()
      additionalContent
    }
    .monospacedDigit()
    .padding(.bottom, Styles.sizeRegular)
    .padding(.horizontal, Styles.sizeRegular)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: layoutAlignment ?? .center)
  }
}

extension StateView {

  private var iconSize: CGFloat {
    let baseIconSize: CGFloat = 46
    return iconFontSize ?? baseIconSize
  }

  @ViewBuilder
  private func TextView() -> some View {
    Text(label.text.toMarkdownCompatible)
      .multilineTextAlignment(.center)
      .font(.system(size: scale(22, for: controlSize)))
      .foregroundStyle(.secondary)
  }

  @ViewBuilder
  private func IconView() -> some View {
    if let icon = label.icon {
      FeatureIconView(icon: icon, fontSize: scale(iconSize, for: controlSize))
        .offset(y: -scale(iconSize * 1.3, for: controlSize))
        .foregroundStyle(.secondary.opacity(0.86))
    }
  }

  @ViewBuilder
  private func MessageView() -> some View {
    if let message = message {
      Text(message)
        .multilineTextAlignment(.center)
        .font(.system(size: scale(15, for: controlSize)))
        .foregroundStyle(.tertiary)
        .padding(.bottom, scale(16, for: controlSize))
    }
  }
}

// MARK: - Initialisers
extension StateView {

  public init(
    _ title: String,
    message: String? = nil,
//    iconSize: CGFloat = 46,
    @ViewBuilder additionalContent: () -> Content = { EmptyView() }
  ) {
    self.label = QuickLabel(title)
    self.message = message
    //    self.iconSize = iconSize
    self.additionalContent = additionalContent()
  }

  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String? = nil,
//    iconSize: CGFloat = 46,
    @ViewBuilder additionalContent: () -> Content = { EmptyView() }
  ) {
    self.label = QuickLabel(title, icon: icon)
    self.message = message
    //    self.iconSize = iconSize
    self.additionalContent = additionalContent()
  }

  public init(
    label: QuickLabel,
    message: String? = nil,
//    iconSize: CGFloat = 46,
    @ViewBuilder additionalContent: () -> Content = { EmptyView() }
  ) {
    self.label = label
    self.message = message
    //    self.iconSize = iconSize
    self.additionalContent = additionalContent()
  }

}
