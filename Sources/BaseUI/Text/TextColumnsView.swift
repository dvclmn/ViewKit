//
//  CharacterColumns.swift
//  BaseComponents
//
//  Created by Dave Coleman on 10/8/2025.
//

import SwiftUI

public struct TextColumns<Content: View>: View {
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns
  @Environment(\.isDebugMode) private var isDebugMode

  let columnCount: Int?
  let alignment: Alignment
  let content: Content

  /// Will use environment's `maxCharacterColumns` if no
  /// value provided for `columnCount`
  public init(
    _ columnCount: Int? = nil,
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.columnCount = columnCount
    self.alignment = alignment
    self.content = content()
  }

  public var body: some View {

    /// `Text` view will not be shown, for layout only
    Text(characters)
      .monospaced()
      .hidden()
      .gridGuide(opacity: 0.3, isEnabled: true)
//      .border(isDebugMode ? Color.green.opacity(0.3) : .clear)
      /// Displays content within character-count-based confines
      .overlay(alignment: alignment) {
        content
          .lineLimit(1)
          .fixedSize()
          .monospacedDigit()
      }
  }
}
extension TextColumns {
  private var characters: String {
    let count = columnCount ?? maxCharacterColumns
    return String(repeating: "0", count: min(count, maxCharacterColumns))
  }
}
