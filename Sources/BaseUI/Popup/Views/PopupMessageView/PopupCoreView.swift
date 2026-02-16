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

      MaybeLabel(popupMessage.label)
        .environment(\.symbolVariants, .fill)
        .environment(\.symbolRenderingMode, .hierarchical)
        .environment(\.iconColour, AnyShapeStyle(.secondary))

        .font(isCompactMode ? .callout : .body.weight(.semibold))
        .fontWeight(.medium)

        /// To leave room for the dismiss button
        .padding(.trailing, hasCloseButton ? 20 : 0)

      if let messageDetail = popupMessage.message {
        Text(messageDetail)
          .foregroundStyle(.secondary)
          .font(isCompactMode ? .caption : .body)
      }
      
      ForEach(popupMessage.actions) { action in
        Button(action.title) {
          return action.action()
        } 
      }
    }  // END vstack

    .multilineTextAlignment(.leading)
    .weightedPadding(
      isCompactMode ? 10 : 17,
      horizontalBias: isCompactMode ? 1.4 : 1.2,
      opticalCentreBias: 1.2,
      excludedEdge: nil
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
