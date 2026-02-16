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

  @State private var shouldAnimateDismissalIndicator: Bool = false

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

      if let duration = popupMessage.dismissal.autoDismissDuration, isShowingIndicator {
        Capsule()
          .fill(.quaternary)
          .fill(
            LinearGradient(
              colors: [.clear, .white.opacity(0.1)],
              startPoint: .center,
              endPoint: .trailing
            )
          )
          .frame(maxWidth: progressBarLength, maxHeight: 5)
          .opacity(shouldAnimateDismissalIndicator ? 1 : 0)
          .padding(.top, Styles.sizeSmall.bumpDown)
          .animation(.linear(duration: duration), value: shouldAnimateDismissalIndicator)
          .frame(maxWidth: .infinity, alignment: .leading)
          .offset(y: isCompactMode ? 2 : 5)

      }
    }  // END vstack

    .multilineTextAlignment(.leading)

    
    //    .overlay {
    //      if let duration = popupMessage.dismissal.autoDismissDuration, isShowingIndicator {
    //
    //        RadialGradient(
    //          colors: [.white.opacity(0.1), .clear],
    //          center: UnitPoint(x: shouldAnimateDismissalIndicator ? 1 : 0, y: 1),
    //          startRadius: 0,
    //          endRadius: shouldAnimateDismissalIndicator ? 140 : 120
    //        )
    //        .animation(
    //          .timingCurve(.easeInOut, duration: duration),
    //          //          .easeInOut(duration: duration),
    //          value: shouldAnimateDismissalIndicator
    //        )
    //      }
    //    }

    .task(id: popupMessage.dismissal.autoDismissDuration) {
      if popupMessage.dismissal.autoDismissDuration != nil {
        self.shouldAnimateDismissalIndicator = true
      } else {
        self.shouldAnimateDismissalIndicator = false
      }
    }
  }
}

extension PopupCoreView {

  var isShowingIndicator: Bool {
    popupMessage.dismissal.shouldShowDismissTimingIndicator
  }
  var progressBarLength: CGFloat {
    shouldAnimateDismissalIndicator ? .infinity : .zero
  }

}
