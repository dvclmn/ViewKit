//
//  PopupCoreView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import SwiftUI

struct PopupCoreView: View {
  @Environment(\.popup) private var popup
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.hasCloseButton) private var hasCloseButton

  let popupMessage: PopupMessage
  var body: some View {

    VStack(alignment: .leading, spacing: isCompactMode ? 4 : 6) {

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
//    .fixedSize(horizontal: false, vertical: true)

    .padding(.horizontal, isCompactMode ? 12 : 20)
    .padding(.top, isCompactMode ? 8 : 13)
    .padding(
      .bottom,
      isCompactMode
        ? 10 : popupMessage.dismissal.shouldShowDismissTimingIndicator ? Styles.sizeMedium.bump : 16)
  }
}
