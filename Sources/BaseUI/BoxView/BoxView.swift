//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import SwiftUI
import StringKit

public struct BoxView<Content: View>: View {
  
  let content: Content
  
  public init(
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content()
  }
  
  public var body: some View {
    content
  }
}
