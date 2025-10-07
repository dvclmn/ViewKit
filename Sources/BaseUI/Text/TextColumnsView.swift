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

  public init(
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.columnCount = nil
    self.content = content()
  }

  public init(
    _ columnCount: Int,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.columnCount = columnCount
    self.content = content()
  }

  public var body: some View {

    Text(characters)
      .monospaced()
      .hidden()
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
    return String(repeating: "0", count: columnCount ?? maxCharacterColumns)
  }
}
