//
//  TextColumnsModifier.swift
//  ViewKit
//
//  Created by Dave Coleman on 30/7/2026.
//

import SwiftUI

struct TextColumnsModifier: ViewModifier {

  let count: Int
  let alignment: Alignment
  func body(content: Content) -> some View {
    TextColumns(count, alignment: alignment) {
      content
    }
  }
}
extension View {
  public func textColumns(
    _ count: Int,
    alignment: Alignment = .leading,
  ) -> some View {
    self.modifier(TextColumnsModifier(count: count, alignment: alignment))
  }
}
