//
//  MaybeLabel.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/2/2025.
//

import CoreTools
import SwiftUI

public struct MaybeLabel: View {
  @Environment(\.labelDisplay) private var labelDisplay

  let label: QuickLabel

  public var body: some View {

    Label {
      if !label.text.isEmpty {
        Text(label.text.toMarkdownCompatible)
      }
    } icon: {
      if let icon = label.icon {
        IconView(icon)
      }
    }
  }
}

// MARK: - Initialisers
extension MaybeLabel {

  public init(_ label: QuickLabel) {
    self.label = label
  }

  public init(
    _ text: String,
    icon: IconLiteral? = nil,
  ) {
    let quickLabel = QuickLabel(text, icon: icon)
    self.label = quickLabel
  }
}
