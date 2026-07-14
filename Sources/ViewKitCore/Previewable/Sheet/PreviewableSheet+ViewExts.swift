//
//  PreviewableSheet+ViewExts.swift
//  ViewKit
//
//  Created by Dave Coleman on 14/7/2026.
//

import SwiftUI

extension View {

  // Presents via a Binding to an optional Item
  public func previewableSheet<Item, Content>(
    item: Binding<Item?>,
    previewItem: Item?,
    @ViewBuilder sheetContent: @escaping (Item) -> Content,
  ) -> some View where Item: Identifiable, Content: View {
    self.modifier(
      PreviewableSheetItemModifier<Content, Item>(
        item: item,
        previewItem: previewItem,
        sheetContent: sheetContent,
      )
    )
  }

  // Presents via `isPresented` Binding<Bool>
  public func previewableSheet<Content>(
    isPresented: Binding<Bool>,
    isPreviewing: Bool,
    @ViewBuilder sheetContent: @escaping () -> Content,
  ) -> some View where Content: View {
    self.modifier(
      PreviewableSheetBoolModifier<Content>(
        isPresented: isPresented,
        isPreviewing: isPreviewing,
        sheetContent: sheetContent,
      )
    )
  }
}
