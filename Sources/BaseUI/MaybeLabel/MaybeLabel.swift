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

  private let placeholderIcon: String = "eye"

  public var body: some View {

    if !isHidden {

      Label {
        Text(label.text)
      } icon: {
        IconView(label.icon ?? .symbol(placeholderIcon))
      }
      /// May need to figure out a 'plain' override
      .labelStyle(.base)

    } else {
      EmptyView()
        .accessibilityLabel(label.text)
    }
  }
}

extension MaybeLabel {
  private var isHidden: Bool { labelDisplay?.isHidden ?? false }

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
