//
//  Font.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import SwiftUI

public enum FontSizeOrStyle {
  case size(CGFloat)
  case style(Font.TextStyle)

  public var size: CGFloat? {
    switch self {
      case .size(let size): size
      case .style: nil
    }
  }

  public var style: Font.TextStyle? {
    switch self {
      case .size: nil
      case .style(let style): style
    }
  }
}

struct FontConfiguration {
  //  let style: Font.TextStyle?
  //  let size: CGFloat?
  let sizeOrStyle: FontSizeOrStyle
  let design: Font.Design
  let weight: Font.Weight

  init(
    //    style: Font.TextStyle? = nil,
    size: CGFloat,
    design: Font.Design = .default,
    weight: Font.Weight = .regular
  ) {
    self.sizeOrStyle = .size(size)
    //    self.style = style
    //    self.size = size
    self.design = design
    self.weight = weight
  }

  init(
    style: Font.TextStyle,
    //    size: CGFloat,
    design: Font.Design = .default,
    weight: Font.Weight = .regular
  ) {
    self.sizeOrStyle = .style(style)
    //    self.style = style
    //    self.size = size
    self.design = design
    self.weight = weight
  }
}

extension FontConfiguration {
  var size: CGFloat? {

  }

  var nsFont: NSFont {
    if let style = style {
      return NSFont.preferredFont(style: style, design: design, weight: weight)
    } else if let size = size {
      return NSFont.preferredFont(size: size, design: design, weight: weight)
    } else {
      // Fallback to body style
      return NSFont.preferredFont(style: .body, design: design, weight: weight)
    }
  }
}

struct SelfSizingTextEditor: NSViewRepresentable {
  @Binding var text: String
  let fontConfig: FontConfiguration

  init(text: Binding<String>, font: FontConfiguration) {
    self._text = text
    self.fontConfig = font
  }

  // Alternative convenience initializers
  init(text: Binding<String>, style: Font.TextStyle, design: Font.Design = .default, weight: Font.Weight = .regular) {
    self.init(text: text, font: FontConfiguration(style: style, design: design, weight: weight))
  }

  init(text: Binding<String>, size: CGFloat, design: Font.Design = .default, weight: Font.Weight = .regular) {
    self.init(text: text, font: FontConfiguration(size: size, design: design, weight: weight))
  }

  func makeNSView(context: Context) -> NSTextView {
    let textView = NSTextView()
    textView.font = fontConfig.nsFont
    // ... rest of setup
    return textView
  }

  func updateNSView(_ nsView: NSTextView, context: Context) {
    nsView.font = fontConfig.nsFont
    // ... rest of update
  }
}
