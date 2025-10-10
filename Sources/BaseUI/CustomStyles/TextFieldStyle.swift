//
//  TextFieldStyle.swift
//  Styles
//
//  Created by Dave Coleman on 30/4/2024.
//
//


import SharedHelpers
import SwiftUI

public struct CustomTextFieldStyle: @preconcurrency TextFieldStyle {
  @Environment(\.layoutAxis) private var layoutAxis
  @Environment(\.layoutAlignment) private var layoutAlignment
  //  @Environment(\.layoutConfig) private var layout
  @MainActor public func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .textFieldStyle(.plain)
      .font(.system(size: 48))
      .padding(.horizontal, Styles.sizeRegular)
      .frame(height: 100)
      //      .frame(maxWidth: .infinity, alignment: layout.alignment)
      .multilineTextAlignment(layoutAlignment?.toTextAlignment ?? .leading)
    //      .border(Color.green.opacity(0.3))
    //      .background(.pink)
    //      .background {
    //        RoundedRectangle(cornerRadius: Styles.sizeSmall)
    //          .fill(.black.opacity(0.1))
    //          .stroke(.white.opacity(0.06), style: .simple01)
    //      }
  }
}

extension TextFieldStyle where Self == CustomTextFieldStyle {
  public static var custom: Self { Self() }
}
