//
//  EmojiView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

// import BaseHelpers
import SwiftUI
import SharedHelpers

public struct FeatureIconView: View {
  @Environment(\.labelDisplay) private var labelDisplay
  let icon: IconLiteral
  let fontSize: CGFloat

  public var body: some View {
    IconView(icon)
      .font(.system(size: fontSize))
      .bouncyDrag()
  }
}

extension FeatureIconView {
  // MARK: - Initialisers

  /// For any `IconLiteral`
  public init(
    _ icon: IconLiteral,
    fontSize: CGFloat = 68
  ) {
    self.icon = icon
    self.fontSize = fontSize
  }

  /// Convenience for just Emoji
  public init(
    emoji: String,
    fontSize: CGFloat = 68
  ) {
    self.init(
      .emoji(emoji),
      fontSize: fontSize
    )
  }
}

#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  FeatureIconView(emoji: "👺")
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
#endif
