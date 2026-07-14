//
//  PreviewableSheet.swift
//  Collection
//
//  Created by Dave Coleman on 23/9/2024.
//
//

import SwiftUI

public struct PreviewableSheetItemModifier<SheetContent: View, Item: Identifiable>: ViewModifier {
  @Environment(\.backgroundMaterial) private var backgroundMaterial

  @Binding var item: Item?
  let previewItem: Item?
  @ViewBuilder let sheetContent: (Item) -> SheetContent

  public func body(content: Content) -> some View {
    content
      .sheet(item: $item) { item in
        sheetContent(item)
      }
      .modifier(
        SheetMockup(
          isPreviewing: isPreviewing,
          sheet: {
            if let item = previewItem {
              sheetContent(item)
            } else {
              Text("Please provide a `Binding<Item?>` to preview.")
            }
          },
        )
      )
      .ignoresSafeArea(edges: isPreviewing ? .all : [])
  }
}
extension PreviewableSheetItemModifier {
  private var isPreviewing: Bool { previewItem != nil }
}
