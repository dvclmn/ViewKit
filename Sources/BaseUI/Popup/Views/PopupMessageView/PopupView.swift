//
//  PopupMessageView.swift
//  Eucalypt
//
//  Created by Dave Coleman on 5/2/2024.
//

import BasePrimitives
import SwiftUI

@MainActor
struct PopupView: View {
  @Environment(\.popup) private var popup
  @Environment(\.isDebugMode) private var isDebugMode
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.hasCloseButton) private var hasCloseButton
  @Environment(\.hasGlassEffect) private var hasGlassEffect
  @Environment(\.colourOverride) private var colourOverride

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
        .quickRoundedBackground(
          glass: hasGlassEffect ? .regular : nil,
          rounding: rounding,
          padding: .zero,
          tint: message.label.role?.colour,
          isEnabled: true
        )
        .depthShadow(
          opacity: 0.2,
          radius: 12,
          distanceY: 30,
          depthIntensity: 0.0
        )

    }
    .frame(
      maxWidth: 360,
      alignment: alignment
    )
    //    .compositingGroup()
    .id(message.id)
    .padding(Styles.sizeRegular)

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
      popup?.popupMessage = nil
    } label: {
      Label("Dismiss", systemImage: Icons.cross.icon)
        .labelStyle(.iconOnly)
        .font(isCompactMode ? .callout.weight(.bold) : .title3.weight(.semibold))
        .foregroundStyle(isHoveringDismiss ? .secondary : .tertiary)
        .padding(isCompactMode ? Styles.sizeSmall.bump : Styles.sizeRegular.bumpDown)
        .contentShape(Rectangle())
      //        .border(Color.green.opacity(0.3))
    }
    .buttonStyle(.plain)
    .onHover { hovering in
      isHoveringDismiss = hovering
    }
  }
}
