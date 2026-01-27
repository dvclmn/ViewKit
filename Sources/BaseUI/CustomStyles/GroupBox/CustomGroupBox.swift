//
//  GroupBox.swift
//  Components
//
//  Created by Dave Coleman on 6/11/2024.
//

import CoreTools
import SwiftUI

public struct CustomGroupBox: GroupBoxStyle {
  @Environment(\.cornerRounding) private var cornerRounding
  @Environment(\.isEmphasised) private var isEmphasised
  @Environment(\.backgroundStyle) private var backgroundStyle
  @Environment(\.layoutPadding) private var layoutPadding

  public init() {}

  public func makeBody(configuration: Configuration) -> some View {

    VStack(alignment: .leading, spacing: Styles.sizeSmall) {
      configuration.label
        .foregroundStyle(.secondary)
        .font(.callout)

      VStack(alignment: .leading, spacing: Styles.sizeRegular) {
        configuration.content
      }
      .padding(.horizontal, padding.h)
      .padding(.top, padding.top)
      .padding(.bottom, padding.bottom)

      .background {
        FilledShape(
          .rect(cornerRadius: cornerRounding ?? Styles.sizeSmall),
          backgroundStyle ?? AnyShapeStyle(Color.white.opacity(0.03)),
          strokeColour: Color.white.opacity(0.1)
        )
        .animation(Styles.animationSpringQuickNSubtle, value: isEmphasised)
      }
    }
  }
}

extension CustomGroupBox {
  private var padding: (h: CGFloat, top: CGFloat, bottom: CGFloat) {
    let base: CGFloat = layoutPadding ?? Styles.sizeRegular
    return (
      h: max(0, base * 1.35),
      top: max(0, base),
      bottom: max(0, base * 1.2),
    )
  }
}

extension GroupBoxStyle where Self == CustomGroupBox {
  public static var custom: CustomGroupBox { CustomGroupBox() }
}
