//
//  PopupMessageView.swift
//  Eucalypt
//
//  Created by Dave Coleman on 5/2/2024.
//

import CoreTools
import ViewTools
import SwiftUI

//import InteractionKit

@MainActor
struct PopupView: View {
  @Environment(\.popup) private var popup
  @Environment(\.isDebugMode) private var isDebugMode
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.hasCloseButton) private var hasCloseButton
  @Environment(\.hasGlassEffect) private var hasGlassEffect
//  @Environment(\.colourOverride) private var colourOverride

  @State private var offsetY: CGFloat = 0
  @State private var isHoveringDismiss: Bool = false

  private let maxWidth: Double = 240
  private let minWidth: Double = 180
  private let rounding: CGFloat = Styles.sizeRegular

  let message: PopupMessage
  let alignment: Alignment
  var body: some View {

    VStack {
      PopupCoreView(popupMessage: message)
        .weightedPadding(
          basePadding,
          horizontalBias: isCompactMode ? 1.4 : 1.2,
          opticalCentreBias: 1.1,
          excludedEdge: nil
        )
        .environment(\.layoutPadding, basePadding)
        .environment(\.layoutAlignment, alignment)

        .overlay(alignment: .topTrailing) {
          if hasCloseButton {
            DismissButton()
          }
        }
        .quickBackground(
          shape: .rounded(rounding),
//        .quickRoundedBackground(
//          rounding: rounding,
          glass: hasGlassEffect ? .regular : nil,
//          padding: .zero,
//          tint: message.label.role?.colour?.toColour,
          isEnabled: true
        )
        .depthShadow(
          opacity: 0.2,
          radius: 12,
          distanceY: 30,
          depthIntensity: 0.0
        )
        .offset(y: offsetY)

    }
    .frame(
      maxWidth: 360,
      alignment: alignment
    )
    .id(message.id)
    .padding(Styles.sizeRegular)
//    .panGesture { delta, _, _ in
////      let new = offsetY + delta.height
//      offsetY += delta.height
//    }

  }

}

extension PopupView {

  private var basePadding: Double {
    isCompactMode ? 10 : 14
  }

  @ViewBuilder
  func PopupContent(_ message: PopupMessage) -> some View {

  }

  @ViewBuilder
  func DismissButton() -> some View {
    Button {
      popup?.dismiss()
    } label: {
      Label("Dismiss", systemImage: Icons.cross.icon)
        .labelStyle(.iconOnly)
        .font(isCompactMode ? .callout.weight(.bold) : .title3.weight(.semibold))
        .foregroundStyle(isHoveringDismiss ? .secondary : .tertiary)
        .padding(isCompactMode ? Styles.sizeSmall.bump : Styles.sizeRegular.bumpDown)
        .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .onHover { hovering in
      isHoveringDismiss = hovering
    }
  }
}
