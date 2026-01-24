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

  public init() {}

  public func makeBody(configuration: Configuration) -> some View {

    VStack(alignment: .leading, spacing: Styles.sizeSmall) {
      configuration.label
        .foregroundStyle(.secondary)

      VStack(alignment: .leading, spacing: Styles.sizeRegular) {
        configuration.content
      }
      .padding(.horizontal, Styles.sizeRegular)
      .padding(.top, Styles.sizeRegular)
      .padding(.bottom, Styles.sizeRegular + 1)
      .background {

        FilledShape(
          .rect(cornerRadius: cornerRounding ?? Styles.sizeTiny),
          backgroundStyle ?? AnyShapeStyle(Color.white.opacity(0.03)),
          strokeColour: Color.white.opacity(0.1)
        )

        .animation(Styles.animationSpringQuickNSubtle, value: isEmphasised)
      }
    }
  }
}

extension GroupBoxStyle where Self == CustomGroupBox {
  public static var custom: CustomGroupBox {
    CustomGroupBox()
  }
}
