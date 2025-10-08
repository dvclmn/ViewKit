//
//  TextFieldStyle.swift
//  Styles
//
//  Created by Dave Coleman on 30/4/2024.
//
//

import BaseHelpers
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

//extension TextFieldStyle {
extension TextFieldStyle where Self == CustomTextFieldStyle {
  //  public static func passthrough(_ config: Self.Config) -> Self {
  //    Self(config: config)
  //  }
  public static var custom: Self { Self() }
}
//extension TextFieldStyle where Self == AnotherCustomTextFieldStyle {
//  public static var custom02: Self { Self() }
//}

//
//@MainActor
//public struct CustomTextField: @preconcurrency TextFieldStyle, Stylable {
//
//  @Environment(\.isEnabled) var isEnabled
//
//  public var config: ElementConfiguration = .default
//  public var icon: String? = nil
//  public var isFocused: Bool = false
//
//  public var alignment: TextAlignment = .leading
//  public var accentColour: Color = .accentColor
//
//  public func _body(configuration: TextField<Self._Label>) -> some View {
//
//    HStack(alignment: .center, spacing: 6) {
//      if let icon = icon {
//        Image(systemName: icon)
//          .font(.system(config.size.fontStyle, weight: config.size.fontWeight))
//          .foregroundStyle(.tertiary)
//      }
//      configuration
//        .multilineTextAlignment(alignment)
//        .textFieldStyle(.plain)
////        .focused($focusedItem, equals: FocusItem)
//        .font(.system(config.size.fontStyle, weight: config.size.fontWeight))
//        .foregroundStyle(.primary.opacity(0.8))
//        .controlSize(config.size.controlSize)
////        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//
//
//    } // END hstack
//    .padding(.leading, Styles.sizeSmall)
//    .padding(.trailing, Styles.sizeTiny)
//
////    .modifier(
////      BaseElementStyle(config: config.with(backgroundType: .simple(style: textFieldBackground())))
////    )
//    .overlay(alignment: .trailing) {
//      if config.action.isShowing {
//        Button {
//          config.action.action()
//        } label: {
//          Label(config.action.label, systemImage: config.action.icon)
//        }
//#warning("Turn this back on")
////        .buttonStyle(.custom.noBackground.size(.mini).iconOnly)
//      }
//    }
////            .border(Color.green.opacity(0.3))
//
//
//
////    .border(Color.green.opacity(0.3))
//
//
//
////    ElementConfiguration(
////      size: size,
////      backgroundType: hasBackground ? .rimlight(degrees: 90, tint: AnyShapeStyle(.white.opacity(0.04))) : .none(hasPadding: false)
////    ))
//
//  }
//}
//
//extension CustomTextField {
//
//  func textFieldBackground() -> ElementBackground {
//    let fill = Color.white
//    let stroke: Color = isFocused ? accentColour.opacity(0.6) : Color.white.opacity(0.05)
//    let lineWidth: CGFloat = isFocused ? 2 : 1
//
//    let result = ElementBackground(
//      fillColour: fill.opacity(searchFieldOpacity),
//      hasMaterial: false,
//      stroke: stroke,
//      lineWidth: lineWidth
//    )
//
//    return result
//
//  }
//
//  var searchFieldOpacity: CGFloat {
//    isFocused ? 0.1 : 0.04
//  }
//
//}
//
//struct TextFieldExample: View {
//
//  @State private var text: String = ""
//  @FocusState var isFocused: Bool
//
//  var body: some View {
//
//    VStack {
//      TextField("A mini example", text: $text)
////        .textFieldStyle(.custom(size: .mini))
//
////      TextField("An example of small", text: $text)
////        .textFieldStyle(.custom(size: .small, actionLabelAndIcon: ("Hello", Icons.getRandomIcon), isShowingActionLabel: false))
//
////      TextField("A normal size", text: $text)
////        .textFieldStyle(.custom(size: .normal, actionLabelAndIcon: ("Hello", Icons.getRandomIcon)))
//      Button {
//
//      } label: {
//        Label("Button example", systemImage: "umbrella")
//      }
//#warning("Turn this back on")
////      .buttonStyle(.custom)
//    }
//    .padding(.horizontal, 30)
//    .padding(.vertical, 200)
//    .background(.red.opacity(0.1))
//
//  }
//}
//
//#if DEBUG
//#Preview {
//  TextFieldExample()
//  //        .frame(width: 300, height: 700)
//}
//
//
//#endif
