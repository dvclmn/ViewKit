//
//  SheetMockupView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/9/2025.
//

import BasePrimitives
import SwiftUI

#warning("Quick background currently switched off, need to find new solution")
struct SheetMockup<Sheet: View>: ViewModifier {

  let isPreviewing: Bool
  @ViewBuilder let sheet: () -> Sheet

  func body(content: Content) -> some View {

    if isPreviewing, isPreview {
      content
        .scrollContentBackground(.hidden)
        .overlay {
          Color.black.opacity(0.8)
            .ignoresSafeArea()
          sheet()
            /// Need to specify zero padding to match actual macOS sheet appearance.
            /// Otherwise this Preview gets padding when the *real* sheet gets none.
//            .quickBackground(
//              shape: .rect(cornerRadius: Styles.sizeMedium.bump),
//              padding: .zero,
//              isEnabled: true,
//            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(Styles.sizeLarge)
            .overlay(alignment: .topLeading) {
              Text("Sheet Preview-Only")
                .font(.caption2)
                .foregroundStyle(.tertiary)
//                .quickBackground(padding: Styles.sizeMicro)
                .padding(Styles.sizeSmall)
            }
        }
    } else {
      content
    }
  }
}
