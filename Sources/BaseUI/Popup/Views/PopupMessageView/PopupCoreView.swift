//
//  PopupCoreView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import SwiftUI

struct PopupCoreView: View {
  @Environment(\.popup) private var popup

  let popupMessage: PopupMessage
  var body: some View {

    VStack(spacing: isCompact ? 4 : 6) {

      PopupTitleView(message: popupMessage, hasCloseButton: hasCloseButton)

      if let messageDetail = popupMessage.message {
        Text(messageDetail)
          .foregroundStyle(.secondary)
          .font(.callout.weight(.medium))
      }
      if let action = popupMessage.action {
        Button(action.title) {
          return action.action()
        }
      }

    }  // END vstack

    .multilineTextAlignment(.leading)
    .fixedSize(horizontal: false, vertical: true)

    .padding(.horizontal, isCompact ? 12 : 20)
    .padding(.top, isCompact ? 8 : 13)
    .padding(.bottom, isCompact ? 10 : isShowingIndicator ? Styles.sizeMedium.bump : 16)

  }
}
