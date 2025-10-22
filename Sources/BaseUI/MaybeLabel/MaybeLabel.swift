//
//  MaybeLabel.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/2/2025.
//

import SharedHelpers
import SwiftUI

public struct MaybeLabel: View {
  @Environment(\.labelDisplay) private var labelDisplay

  let label: QuickLabel

  public init(_ label: QuickLabel) {
    self.label = label
  }

  public init(
    _ text: String, icon: IconLiteral? = nil
  ) {
    let quickLabel = QuickLabel(text, icon: icon)
    self.label = quickLabel
  }
  public var body: some View {

    if let icon = label.icon {
      Label {
        Text(label.attributedText)
      } icon: {
        IconView(icon)
      }

    } else {
      Text(label.attributedText)
    }
  }
}
