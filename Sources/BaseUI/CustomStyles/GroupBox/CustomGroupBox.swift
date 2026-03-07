//
//  GroupBox.swift
//  Components
//
//  Created by Dave Coleman on 6/11/2024.
//

import BasePrimitives
import SwiftUI

public struct CustomGroupBox: GroupBoxStyle {
  @Environment(\.cornerRounding) private var cornerRounding
  @Environment(\.isEmphasised) private var isEmphasised
  @Environment(\.backgroundStyle) private var backgroundStyle
  @Environment(\.layoutPadding) private var layoutPadding

  public init() {}

  public func makeBody(configuration: Configuration) -> some View {

    /// Reminder: This controls the stacking and spacing between
    /// the header part and the content part. A small spacing value here
    /// prevents the heading from being pushed too far from the content
    VStack(alignment: .leading, spacing: Styles.sizeTiny) {
      configuration.label
        .foregroundStyle(.secondary)
        .font(.callout)

      VStack(alignment: .leading, spacing: Styles.sizeRegular) {
        configuration.content
      }
      .padding(.horizontal, padding.horizontal)
      .padding(.top, padding.top)
      .padding(.bottom, padding.bottom)

      .background {
        FilledShape(
          .rect(cornerRadius: cornerRounding ?? Styles.sizeSmall),
          style: backgroundStyle ?? AnyShapeStyle(Color.black.opacity(0.14)),
          //            style: backgroundStyle ?? AnyShapeStyle(Color.white.opacity(0.03)),
          strokeColour: Color.white.opacity(0.0)
        )
        .animation(Styles.animationSpringQuickNSubtle, value: isEmphasised)
      }
      //      }
    }
  }
}

extension CustomGroupBox {
  private var padding: (horizontal: CGFloat, top: CGFloat, bottom: CGFloat) {
    let base: CGFloat = layoutPadding ?? Styles.sizeRegular
    return (
      horizontal: max(0, base * 1.35),
      top: max(0, base),
      bottom: max(0, base * 1.2),
    )
  }
}

extension GroupBoxStyle where Self == CustomGroupBox {
  public static var custom: CustomGroupBox { CustomGroupBox() }
}
