//
//  ToolTipView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/10/2025.
//

import SharedHelpers
import SwiftUI

struct ToolTipView: View {

  @Environment(\.itemColour) private var itemColour
  private let style: ToolTipStyle = .capsule

  let text: String
  let isShowing: Bool
  var body: some View {

    Group {
      if isShowing {
        Text(text)
          .fixedSize(horizontal: true, vertical: false)
          .foregroundStyle(.primary.opacity(0.85))
          //          .font(.body)
//          .padding(.horizontal, Styles.sizeMicro)
//          .padding(.vertical, Styles.sizeNano)
//          .quickBackground(
//            shape: .capsule,
//            //            shape: style.isCapsule ? .capsule : .rect(cornerRadius: CGFloat.defaultQuickRounding),
//            tint: itemColour ?? Color.black.opacity(0.6)
//          )
          .background(.regularMaterial)
          .background(.tint.secondary)
          .clipShape(.rounded)

      }
    }
    .transition(
      .asymmetric(
        insertion: .opacity.animation(.easeOut(duration: 0.01)),
        removal: .opacity.animation(Styles.animationSpringQuickNSubtle)
      )
    )
  }
}

//@CaseDetection
enum ToolTipStyle {
  case rounded
  case capsule
}
