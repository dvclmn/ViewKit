//
//  SheetMockupView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/9/2025.
//

import BasePrimitives
import SwiftUI

struct SheetMockup<Sheet: View>: ViewModifier {

  let isPreviewing: Bool
  @ViewBuilder let sheet: () -> Sheet

  func body(content: Content) -> some View {

    if isPreviewing, isPreview {
      content
        .overlay {
          Color.black.opacity(0.8)
            .ignoresSafeArea()
          sheet()
            /// Intentionally leaving padding nil here, to allow customisation
            /// out at the call site
            .quickBackground(
              shape: .rect(cornerRadius: Styles.sizeMedium),
              isEnabled: true,
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(Styles.sizeLarge)
            .overlay(alignment: .topLeading) {
              Text("Sheet Preview-Only")
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .quickBackground(padding: Styles.sizeMicro)
                .padding(Styles.sizeSmall)
            }
        }
    } else {
      content
    }
  }
}
