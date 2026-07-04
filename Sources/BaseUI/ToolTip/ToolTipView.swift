//
//  ToolTipView.swift
//  ViewKit
//
//  Created by Dave Coleman on 21/10/2025.
//

import CoreTools
import ViewTools
import SwiftUI

struct ToolTipView: View {
//  @Environment(\.colourOverride) private var colourOverride
  
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
          .padding(.horizontal, 2)
          .padding(.vertical, 1)
          .quickBackground(
            shape: .capsule,
            //            shape: style.isCapsule ? .capsule : .rect(cornerRadius: CGFloat.defaultQuickRounding),
          )
          
//          .background(.regularMaterial)

//          .background(colourOverride ?? Color.black.opacity(0.6))
//          .clipShape(.rounded)

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
