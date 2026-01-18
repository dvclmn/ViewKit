//
//  CharacterColumns.swift
//  BaseComponents
//
//  Created by Dave Coleman on 10/8/2025.
//

import SwiftUI

public struct TextColumns<Content: View>: View {
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns

  let columnCount: Int?
  let content: Content

  /// Will use environment's `maxCharacterColumns` if no
  /// value provided for `columnCount`
  public init(
    _ columnCount: Int? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.columnCount = columnCount
    self.content = content()
  }

  public var body: some View {

    /// `Text` view will not be shown, for layout only
    Text(characters)
      .monospaced()
      .hidden()
    
    /// Displays content within character-count-based confines
      .overlay(alignment: .trailing) {
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
