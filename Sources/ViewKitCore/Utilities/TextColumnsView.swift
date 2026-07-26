//
//  CharacterColumns.swift
//  BaseComponents
//
//  Created by Dave Coleman on 10/8/2025.
//

import SwiftUI

/// Previously relied on the GridKit `.characterSize` modifier,
/// now takes character size as parameter
public struct TextColumns<Content: View>: View {
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns
  @Environment(\.isDebugMode) private var isDebugMode

  let columnCount: Int?
  let characterSize: CGSize
  let alignment: Alignment
  let content: () -> Content

  /// Will use environment's `maxCharacterColumns` if no
  /// value provided for `columnCount`
  public init(
    _ columnCount: Int? = nil,
    characterSize: CGSize,
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content,
  ) {
    self.columnCount = columnCount
    self.characterSize = characterSize
    self.alignment = alignment
    self.content = content
  }

  public var body: some View {

    /// `Text` view will not be shown, it's for layout only
    Text(characters)
      .monospaced()
      .hidden()
      .debugFrame(.purple)

      /// Displays content within character-count-based confines
      .overlay(alignment: alignment) {
        content()
          .lineLimit(1)
          .fixedSize()
          .monospacedDigit()
      }
  }
}
extension TextColumns {

  private var columnWidth: Int { columnCount ?? maxCharacterColumns }

  private var characters: String {
    return String(repeating: "0", count: min(columnWidth, maxCharacterColumns))
  }
}
