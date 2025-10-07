//
//  SheetMockupView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/9/2025.
//

import BaseHelpers
import SharedHelpers
import SwiftUI

struct SheetMockup<Sheet: View>: ViewModifier {

  let isPreviewing: Bool
  @ViewBuilder let sheet: () -> Sheet

  func body(content: Content) -> some View {

    if isPreviewing, isPreview {
      ZStack {
        content
        Color.black.opacity(0.4)
          .ignoresSafeArea()
        sheet()
          .clipShape(.rect(cornerRadius: Styles.sizeMedium))
          //          .background {
          //            RimLightShape(fillStyle: AnyShapeStyle(.regularMaterial)) {
          //              RoundedRectangle(cornerRadius: Styles.sizeSmall.bump)
          //            }
          //          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(Styles.sizeLarge)
          .overlay(alignment: .topLeading) {
            Text("Sheet Preview-Only")
              .font(.caption2)
              .foregroundStyle(.tertiary)
              .quickBackground()
              .padding(Styles.sizeSmall)
          }
      }
    } else {
      content
    }
  }
}
