//
//  TextForLayout.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/12/2025.
//

import SwiftUI

public struct LayoutTextModifier: ViewModifier {
  
  public func body(content: Content) -> some View {
    content
      .hidden()
    /// Note: Keep this frame, with maxWidth inifinity.
    /// Seems to work nicely.
      .frame(
        maxWidth: .infinity,
        alignment: .topLeading
      )
  }
}


//package struct TextForLayout: View {
//  private let attributedText: Binding<AttributedString>?
//  private let plainText: Binding<String>?
//
//  package init(
//    attributed: Binding<AttributedString>?,
//    plain: Binding<String>?
//  ) {
//    self.attributedText = attributed
//    self.plainText = plain
//  }
//
//  package var body: some View {
//
//    Group {
//      if let attributedText {
//        Text(attributedText.wrappedValue)
//      } else if let plainText {
//        Text(plainText.wrappedValue)
//      } else {
//        Text("No text found")
//      }
//    }
//
//  }
//}

