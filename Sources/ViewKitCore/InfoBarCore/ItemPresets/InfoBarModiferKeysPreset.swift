//
//  InfoBarModiferKeysPreset.swift
//  ViewKit
//
//  Created by Dave Coleman on 26/8/2026.
//

import SwiftUI

struct ExampleModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
  }
}
extension View {
  public func example() -> some View {
    self.modifier(ExampleModifier())
  }
}
