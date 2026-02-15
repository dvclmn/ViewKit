//
//  PopupMessageView.swift
//  Eucalypt
//
//  Created by Dave Coleman on 5/2/2024.
//

//import BaseUI

import BasePrimitives
import SwiftUI

@MainActor
struct PopupView: View {
  @Environment(\.popup) private var popup
  @Environment(\.isDebugMode) private var isDebugMode
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.hasCloseButton) private var hasCloseButton

  @State private var isHoveringDismiss: Bool = false
  @State private var shouldStartProgressBar: Bool = false

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
        .overlay(alignment: .bottom) {
          if let duration = popupMessage.dismissal.autoDismissDuration, isShowingIndicator {
            Capsule()
              .fill(.quaternary)
              .frame(maxWidth: progressBarLength, maxHeight: 5)
              .padding(.horizontal, Styles.sizeSmall.bump)
              .padding(.bottom, Styles.sizeSmall.bumpDown)
              .animation(.linear(duration: duration), value: shouldStartProgressBar)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
        .background(.thinMaterial)
      
        .clipShape(.rect(cornerRadius: rounding))
        .overlay {
          RoundedRectangle(cornerRadius: rounding)
            .fill(.clear)
            .stroke(LinearGradient.lightFalloff(), style: .simple01)
        }
        .shadow(color: .black.opacity(0.2), radius: 40, x: 0, y: 18)
        .shadow(color: .black.opacity(0.2), radius: 9, x: 0, y: 1)
    }
    .compositingGroup()

    .id(popupMessage.id)

    .onAppear {
      if popupMessage.dismissal.autoDismissDuration != nil {
        self.shouldStartProgressBar = true
      } else {
        self.shouldStartProgressBar = false
      }
    }
  }

}

extension PopupView {

  var isShowingIndicator: Bool {
    popupMessage.dismissal.shouldShowDismissTimingIndicator
  }

  var progressBarLength: CGFloat {
    shouldStartProgressBar ? .infinity : .zero
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
