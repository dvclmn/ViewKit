//
//  PreviewableSheet.swift
//  Collection
//
//  Created by Dave Coleman on 23/9/2024.
//
//

import SwiftUI

// MARK: - Takes an optional Item Binding
public struct PreviewableSheetItemModifier<SheetContent: View, Item: Identifiable>: ViewModifier {
  @Environment(\.backgroundMaterial) private var backgroundMaterial

  @Binding var item: Item?
  let previewItem: Item?
  @ViewBuilder let sheetContent: (Item) -> SheetContent

  public func body(content: Content) -> some View {
    content
      .sheet(item: $item) { item in
        sheetContent(item)
        //          .presentationBackground(AnyShapeStyle(backgroundMaterial ?? .thinMaterial))
      }
      .modifier(
        SheetMockup(
          isPreviewing: previewItem != nil,
          sheet: {
            if let item = previewItem {
              sheetContent(item)
            } else {
              StateView("Please provide a `Binding<Item?>` to preview.")
                .environment(\.isCompactMode, true)
            }
          }
        )
      )
      .ignoresSafeArea(edges: previewItem != nil ? .all : [])
  }
}

// MARK: - Takes a Binding Bool (isPresented)
public struct PreviewableSheetBoolModifier<SheetContent: View>: ViewModifier {
  @Environment(\.backgroundMaterial) private var backgroundMaterial

  @Binding var isPresented: Bool
  let isPreviewing: Bool
  @ViewBuilder let sheetContent: () -> SheetContent

  public func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        if #available(macOS 13.3, *) {
          sheetContent()
//            .presentationBackground(AnyShapeStyle(backgroundMaterial ?? .thinMaterial))
        } else {
          sheetContent()
          // Fallback on earlier versions
        }
      }
      .modifier(
        SheetMockup(isPreviewing: isPreviewing) {
          sheetContent()
        }
      )

    //      .ignoresSafeArea(edges: isPreviewing ? .all : [])
  }
}

extension View {
  public func previewableSheet<Item, Content>(
    item: Binding<Item?>,
    previewItem: Item?,
    @ViewBuilder sheetContent: @escaping (Item) -> Content
  ) -> some View where Item: Identifiable, Content: View {
    self.modifier(
      PreviewableSheetItemModifier<Content, Item>(
        item: item,
        previewItem: previewItem,
        sheetContent: sheetContent
      )
    )
  }

  public func previewableSheet<Content>(
    isPresented: Binding<Bool>,
    isPreviewing: Bool,
    @ViewBuilder sheetContent: @escaping () -> Content
  ) -> some View where Content: View {
    self.modifier(
      PreviewableSheetBoolModifier<Content>(
        isPresented: isPresented,
        isPreviewing: isPreviewing,
        sheetContent: sheetContent
      )
    )
  }
}
