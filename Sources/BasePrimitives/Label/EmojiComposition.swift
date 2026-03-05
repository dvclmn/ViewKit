//
//  EmojiComposition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

import SwiftUI

public struct Emoji: Identifiable, Equatable, Sendable, Hashable, Codable {
  public let id: UUID
  public let emoji: Character
  public let offset: CGSize
  public let rotation: Angle
  public let scale: CGFloat

  public init(
    id: UUID = UUID(),
    emoji: Character,
    offset: CGSize = .zero,
    rotation: Angle = .zero,
    scale: CGFloat = 1.0
  ) {
    self.id = id
    self.emoji = emoji
    self.offset = offset
    self.rotation = rotation
    self.scale = scale
  }
}

public struct EmojiComposition: Sendable, Equatable, Codable, Hashable {
  public let emoji: [Emoji]
  public let scale: CGFloat

  public init(
    emoji: [Emoji],
    scale: CGFloat = 1.0
  ) {
    self.emoji = emoji
    self.scale = scale
  }
}

extension EmojiComposition {
  public static let example: Self = .init(
    emoji: [
      Emoji(
        emoji: "📎",
        offset: CGSize(-30, 14),
        rotation: .degrees(4),
        scale: 0.8
      ),
      Emoji(
        emoji: "✂️",
        offset: CGSize(26, -14),
        rotation: .degrees(16),
        scale: 1.0
      ),
    ],
    scale: 2.8
  )
}
