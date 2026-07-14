//
//  PreviewableSheet+Bool.swift
//  ViewKit
//
//  Created by Dave Coleman on 14/7/2026.
//

import SwiftUI

public struct PreviewableSheetBoolModifier<SheetContent: View>: ViewModifier {
  @Environment(\.backgroundMaterial) private var backgroundMaterial

  @Binding var isPresented: Bool
  let isPreviewing: Bool
  @ViewBuilder let sheetContent: () -> SheetContent

  public func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        //        if #available(macOS 13.3, *) {
        sheetContent()
        //            .presentationBackground(AnyShapeStyle(backgroundMaterial ?? .thinMaterial))
        //        } else {
        //          sheetContent()
        // Fallback on earlier versions
        //        }
      }
      .modifier(
        SheetMockup(isPreviewing: isPreviewing) {
          sheetContent()
        }
      )

    //      .ignoresSafeArea(edges: isPreviewing ? .all : [])
  }
}
