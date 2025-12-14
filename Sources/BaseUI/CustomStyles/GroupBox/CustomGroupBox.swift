//
//  GroupBox.swift
//  Components
//
//  Created by Dave Coleman on 6/11/2024.
//


import SharedHelpers
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
        
//        RoundedRectangle(cornerRadius: cornerRounding ?? Styles.sizeTiny)
//          .fill(backgroundStyle ?? AnyShapeStyle(Color.white.opacity(0.03)))
//        
//        
//        
////          .fill(.white.opacity(emphasis == .selected ? 0.06 : 0.03))
//          .stroke(
//            Color.white.opacity(0.1),
////            strokeConfig.colour,
////            strokeConfig.colour.opacity(emphasis == .selected ? 1.0 : 0.6),
//            lineWidth: 1.0
////            lineWidth: strokeConfig.thickness
//          )
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

struct CustomGroupBoxView: View {

  var body: some View {

    GroupBox("Start Point") {
      HStack {
        Rectangle()
          .aspectRatio(1, contentMode: .fit)
          .frame(maxWidth: 60)

        Text(DummyContent.Strings.paragraphs[6])
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .groupBoxStyle(.custom)
    .padding(120)

  }
}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  CustomGroupBoxView()
}
#endif
