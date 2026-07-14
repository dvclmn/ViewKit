//
//  ItemViewCommonModifier.swift
//  ViewKit
//
//  Created by Dave Coleman on 14/7/2026.
//

import SwiftUI
import ViewTools

struct ItemViewCommonModifier: ViewModifier {
  @Environment(\.isEmphasised) private var isEmphasised
  @Environment(\.isHovering) private var isHovering
  let cardSize: CGSize

  func body(content: Content) -> some View {
    content
      .labelStyle(.base)
      .environment(\.labelDisplay, .stacked)
      .environment(\.symbolRenderingMode, .hierarchical)
      .environment(\.symbolVariants, .fill)
      .iconColour(isEmphasised ? .primary : .secondary)
      .environment(\.iconFontStyle, .title)
      .multilineTextAlignment(.center)
      .padding(Styles.sizeTiny)
      .frame(
        width: cardSize.width,
        height: cardSize.height,
        alignment: .center,
      )
      .quickBackground(
        shape: .rect(cornerRadius: Styles.sizeSmall.bump),
        glass: .regular(tint: tintColour),
        padding: .zero,
      )
//      .backgroundTint(.white.opacity(tintOpacity))
  }
}

extension ItemViewCommonModifier {
  private var tintColour: Color? {
    let removing = isHovering && !isEmphasised
    switch (removing, isEmphasised) {
      case (true, _): return .red.opacity(0.3)
      case (false, true): return .white.opacity(0.1)
      default: return nil
    }
  }
  
  private var tintOpacity: CGFloat {
    switch (isHovering, isEmphasised) {
      case (true, true): return 1.0
      case (false, true): return 0.9
      case (true, _): return 0.4
      default: return 0.0
    }
  }
}
