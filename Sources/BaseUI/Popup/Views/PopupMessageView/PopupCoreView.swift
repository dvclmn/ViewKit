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

  @State private var shouldStartProgressBar: Bool = false

  let popupMessage: PopupMessage
  var body: some View {

    VStack(alignment: .leading, spacing: isCompactMode ? 4 : 6) {

      //      PopupTitleView(message: popupMessage, hasCloseButton: hasCloseButton)

      MaybeLabel(popupMessage.label)
        .environment(\.symbolVariants, .fill)
        .environment(\.symbolRenderingMode, .hierarchical)
        .environment(\.iconColour, AnyShapeStyle(.secondary))

        .font(isCompactMode ? .callout : .headline)
        .fontWeight(.medium)

        /// To leave room for the dismiss button
        .padding(.trailing, hasCloseButton ? 20 : 0)

      if let messageDetail = popupMessage.message {
        Text(messageDetail)
          .foregroundStyle(.secondary)
          .font(isCompactMode ? .caption : .body)
      }
      if let action = popupMessage.action {
        Button(action.title) {
          return action.action()
        }
      }

      if let duration = popupMessage.dismissal.autoDismissDuration, isShowingIndicator {
        Capsule()
          .fill(.quaternary)
          .frame(maxWidth: progressBarLength, maxHeight: 5)
          .padding(.horizontal, Styles.sizeSmall.bump)
          .padding(.bottom, Styles.sizeSmall.bumpDown)
          .animation(.linear(duration: duration), value: shouldStartProgressBar)
          .frame(maxWidth: .infinity, alignment: .leading)
      }

    }  // END vstack

    .multilineTextAlignment(.leading)
    //    .fixedSize(horizontal: false, vertical: true)

    .padding(.horizontal, isCompactMode ? 12 : 20)
    .padding(.top, isCompactMode ? 8 : 13)
    .padding(
      .bottom,
      isCompactMode
        ? 10 : popupMessage.dismissal.shouldShowDismissTimingIndicator ? Styles.sizeMedium.bump : 16
    )

    .onAppear {
      if popupMessage.dismissal.autoDismissDuration != nil {
        self.shouldStartProgressBar = true
      } else {
        self.shouldStartProgressBar = false
      }
    }
  }
}

extension PopupCoreView {

  var isShowingIndicator: Bool {
    popupMessage.dismissal.shouldShowDismissTimingIndicator
  }
  var progressBarLength: CGFloat {
    shouldStartProgressBar ? .infinity : .zero
  }

}
