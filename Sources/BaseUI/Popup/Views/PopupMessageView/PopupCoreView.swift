//
//  PopupCoreView.swift
//  ViewKit
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
// import LayoutKit
import SwiftUI
import ViewTools

//import UIPrimitives

struct PopupCoreView: View {
  @Environment(\.popup) private var popup
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.layoutPadding) private var layoutPadding
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.hasCloseButton) private var hasCloseButton

  @State private var shouldAnimateDismissalIndicator: Bool = false

  let popupMessage: PopupMessage
  var body: some View {

    VStack(alignment: .leading, spacing: spacing) {

      QuickLabel(popupMessage.label)
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
        .controlSize(isCompactMode ? .small : .regular)
        .offset(y: downwardOffset)
      }

      if let duration = popupMessage.dismissal.autoDismissDuration, isShowingIndicator,
        popupMessage.actions.isEmpty
      {

        Capsule()
          .fill(.quaternary)
          .fill(
            LinearGradient(
              colors: [.clear, .white.opacity(0.1)],
              startPoint: .center,
              endPoint: .trailing,
            )
          )
          .frame(maxWidth: progressBarLength, maxHeight: 5)
          .opacity(shouldAnimateDismissalIndicator ? 1 : 0)
          .padding(.top, Styles.sizeSmall.bumpDown)
          .animation(.linear(duration: duration), value: shouldAnimateDismissalIndicator)
          .frame(maxWidth: .infinity, alignment: .leading)
          .offset(y: downwardOffset)

      }
    }  // END vstack
    .frame(
      minWidth: 200,
      //      maxWidth: 360,
      alignment: .leading,
        //      alignment: layoutAlignment ?? .trailing
    )
    .multilineTextAlignment(.leading)

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

  private var downwardOffset: Double {
    let factor: Double = isCompactMode ? 0.15 : 0.15
    return layoutPadding.map { $0 * factor } ?? 0
  }
  private var spacing: Double {
    let factor = isCompactMode ? 0.7 : 1

    let base: Double = popupMessage.actions.isEmpty ? 7 : 12

    return max(0, base * factor)
  }

  var isShowingIndicator: Bool {
    popupMessage.dismissal.shouldShowDismissTimingIndicator
  }
  var progressBarLength: CGFloat {
    shouldAnimateDismissalIndicator ? .infinity : .zero
  }

}
