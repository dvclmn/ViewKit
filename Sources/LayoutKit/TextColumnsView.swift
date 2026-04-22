//
//  CharacterColumns.swift
//  BaseComponents
//
//  Created by Dave Coleman on 10/8/2025.
//

import SwiftUI
//import GridKit

public struct TextColumns<Content: View>: View {
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns
  @Environment(\.isDebugMode) private var isDebugMode

  @State private var characterSize: CGSize?

  let columnCount: Int?
  let alignment: Alignment
  let content: () -> Content

  /// Will use environment's `maxCharacterColumns` if no
  /// value provided for `columnCount`
  public init(
    _ columnCount: Int? = nil,
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.columnCount = columnCount
    self.alignment = alignment
    self.content = content
  }

  public var body: some View {

    /// `Text` view will not be shown, for layout only
    Text(characters)
      .monospaced()
      .hidden()
      //      .frame(minWidth: screenWidth)
      //      .gridGuide(opacity: 0.3, isEnabled: isDebugMode)
      .environment(\.gridDimensions, .init(columnWidth, 1))
      //      .setGridDimensions(columnWidth, height: 1)
      .characterSize(
        config: .passthrough,
        //        for: font, size: fontSize,
        mode: .debounce(0.2),
        shouldSetEnv: true
      ) { size in
        self.characterSize = size
      }

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
