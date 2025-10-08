//
//  TextTone.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/8/2025.
//

import SwiftUI

public struct TextToneModifier: ViewModifier {

  let tone: TextTone
  public func body(content: Content) -> some View {
    content
      .foregroundStyle(tone.foregroundStyle)
      .italic(tone.isItalicised)
  }
}
extension View {
  public func textTone(_ tone: TextTone) -> some View where Self == Text {
    self.modifier(TextToneModifier(tone: tone))
  }
}

public enum TextTone {
  case normal
  case quiet

  var isItalicised: Bool {
    switch self {
      case .normal: false
      case .quiet: true
    }
  }
  var foregroundStyle: AnyShapeStyle {
    switch self {
      case .normal: Color.primary.toShapeStyle
      case .quiet: AnyShapeStyle(.tertiary)
    }
  }
}
