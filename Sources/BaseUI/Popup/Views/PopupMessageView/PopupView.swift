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

  let popupMessage: PopupMessage

  init(
    message: PopupMessage,
  ) {
    self.popupMessage = message
  }

  init?(
    _ message: PopupMessage?,
  ) {
    guard let message else { return nil }
    self.popupMessage = message
  }

  var body: some View {

    VStack {
      PopupCoreView(popupMessage: popupMessage)
        .overlay(alignment: .topTrailing) {
          if hasCloseButton {
            DismissButton()
          }
        }
        .quickRoundedBackground(
          glass: hasGlassEffect ? .regular : nil,
          rounding: rounding,
          padding: .zero,
          tint: popupMessage.label.role?.colour,
//          tint: colourOverride ?? AnyShapeStyle(popupMessage.label.role?.colour),
          isEnabled: true
        )

        .shadow(color: .black.opacity(0.2), radius: 40, x: 0, y: 18)
        .shadow(color: .black.opacity(0.2), radius: 9, x: 0, y: 1)
    }
    .compositingGroup()
    .id(popupMessage.id)

  }

}

extension PopupView {

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
        .font(.caption.weight(.bold))
        .foregroundStyle(isHoveringDismiss ? .secondary : .tertiary)
        .padding(Styles.sizeSmall)
        .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .onHover { hovering in
      isHoveringDismiss = hovering
    }
  }
}
