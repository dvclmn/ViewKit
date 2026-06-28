//
//  InfoBarViewDirect.swift
//  ViewKit
//
//  Created by Dave Coleman on 9/3/2026.
//

import SwiftUI

struct InfoBarViewDirect: ViewModifier {
  
  func body(content: Content) -> some View {
    content
    
  }
}
extension View {
  public func example() -> some View {
    self.modifier(InfoBarViewDirect())
  }
}
