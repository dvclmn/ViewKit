//
//  File.swift
//
//
//  Created by Dave Coleman on 27/5/2024.
//

import BasePrimitives
import SwiftUI
import LayoutKit
//import UIPrimitives

public struct StateView<Content: View>: View {
  @Environment(\.layoutType) private var layoutType
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.layoutPadding) private var layoutPadding
  @Environment(\.isCompactMode) private var isCompact
  @Environment(\.iconFontSize) private var iconFontSize
  @Environment(\.controlSize) private var controlSize

  let label: QuickLabel
  let message: String?
  let additionalContent: Content

  public var body: some View {

    DecomposedView(.subview, layout: .vstack(alignment: .center)) {
      // MARK: - Title
      TitleView()
        /// Padding to achieve nice vertical optical centering
        .safePaddingCompatible(.top, paddingLength)

      // MARK: - Message
      MessageView()
      additionalContent
    }
    .monospacedDigit()
    .padding(.vertical, layoutPadding ?? Styles.sizeRegular)
    .padding(.horizontal, layoutPadding ?? Styles.sizeRegular)
  }
}

extension StateView {

  private var paddingLength: CGFloat {
    (label.icon != nil && !layoutType.isHstack)
      ? controlSize.scale(iconSize * 1.4)
      : .zero
  }
  private var iconSize: CGFloat {
    let baseIconSize: CGFloat = 46
    return iconFontSize ?? baseIconSize
  }

  @ViewBuilder
  private func TitleView() -> some View {
    Group {
      switch layoutType {
        case .hstack:
          MaybeLabel(label)

        default:
          Text(label.text.toMarkdownCompatible)
            /// Pan gesture view was causing `FeatureIconView` to take
            /// up too much space, so using overlay to keep it contained better
            .overlay(alignment: .top) {
              IconView()
            }
      }
    }  // END group
    .multilineTextAlignment(.center)
    .font(.system(controlSize.textStyle))
    .foregroundStyle(.secondary)
  }

  @ViewBuilder
  private func IconView() -> some View {
    if let icon = label.icon {
      FeatureIconView(icon: icon, fontSize: controlSize.scale(iconSize))
        .offset(y: -controlSize.scale(offsetAmount(icon)))
        .foregroundStyle(.secondary.opacity(0.86))
    }
  }

  @ViewBuilder
  private func MessageView() -> some View {
    if let message = message {
      Text(message)
        .multilineTextAlignment(.center)
        .font(.system(size: controlSize.scale(15)))
        .foregroundStyle(.tertiary)
        .padding(.bottom, controlSize.scale(16))
    }
  }
}

extension StateView {
  private func offsetAmount(_ icon: IconLiteral) -> CGFloat {
    icon.isEmojiComposition
      ? iconSize * 1.7
      : iconSize * 1.3
  }
}

// MARK: - Initialisers
extension StateView {

  public init(
    _ title: String,
    message: String? = nil,
    @ViewBuilder additionalContent: () -> Content = { EmptyView() }
  ) {
    self.label = QuickLabel(title)
    self.message = message
    self.additionalContent = additionalContent()
  }

  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String? = nil,
    @ViewBuilder additionalContent: () -> Content = { EmptyView() }
  ) {
    self.label = QuickLabel(title, icon: icon)
    self.message = message
    self.additionalContent = additionalContent()
  }

  public init(
    label: QuickLabel,
    message: String? = nil,
    @ViewBuilder additionalContent: () -> Content = { EmptyView() }
  ) {
    self.label = label
    self.message = message
    self.additionalContent = additionalContent()
  }

}
