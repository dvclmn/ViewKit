//
//  TextLineCount.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

// Full credit for this code goes to Kieraj Mumick, from this article:
// https://medium.com/@kieraj_82811/counting-the-number-of-rendered-lines-in-swiftui-text-1151c4ba8a72

import SwiftUI


public struct TextLineCountViewModifier: ViewModifier {
  @State private var numberOfLines: Int = 0

  let onChange: (Int) -> Void

  public func body(content: Content) -> some View {

    content.onPreferenceChange(Text.LayoutKey.self) { textLayout in
      var count = 0

      for layout in textLayout {
        count += layout.layout.count
      }

      if count != numberOfLines {
        onChange(count)
      }
      numberOfLines = count
    }
  }
}


extension View {
  /// Counts the number of lines it takes to draw a string,
  /// including word wrapping.
  ///
  /// This doesn't count the number of newline characters in a string.
  public func textLineCount(_ onChange: @escaping (Int) -> Void) -> some View {
    modifier(TextLineCountViewModifier(onChange: onChange))
  }
}
