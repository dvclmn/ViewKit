//
//  MaybeLabel.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/2/2025.
//

import BasePrimitives
import SwiftUI

public struct MaybeLabel: View {
  @Environment(\.labelDisplay) private var labelDisplay

  let label: QuickLabel
  let isPlain: Bool

  public var body: some View {

    MainLabelView()

  }
}

extension MaybeLabel {
  private var isHidden: Bool {
    labelDisplay?.isHidden ?? false
  }

  @ViewBuilder
  private func MainLabelView() -> some View {
    if let icon = label.icon {
      Label {
        Text(label.text)
      } icon: {

        /// Icon-specific styles in here

        if isPlain {
          IconView(icon)
        } else {
          IconView(icon)
            .commonLabelStyles(for: .icon, display: labelDisplay)
        }
      }

    } else {
      if isHidden {
        Label {
          Text(label.text)
        } icon: {
          EmptyView()
        }
        .labelsHidden()

      } else {
        Text(label.text)
      }
    }
  }
}

// MARK: - Initialisers
extension MaybeLabel {

  public init(
    _ label: QuickLabel,
    isPlain: Bool = false
  ) {
    self.label = label
    self.isPlain = isPlain
  }

  public init(
    _ text: String,
    icon: IconLiteral? = nil,
    isPlain: Bool = false
  ) {
    let quickLabel = QuickLabel(text, icon: icon)
    self.label = quickLabel
    self.isPlain = isPlain
  }

  public init(
    _ text: String,
    symbol: String?,
    isPlain: Bool = false
  ) {
    if let symbol {
      let quickLabel = QuickLabel(text, icon: .symbol(symbol))
      self.label = quickLabel

    } else {
      self.label = QuickLabel(text, icon: nil)
    }
    self.isPlain = isPlain
  }
}
