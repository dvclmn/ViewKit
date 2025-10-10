//
//  NoSpaceLayout.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

import SwiftUI

public struct HPack<Content: View>: View {

  let alignment: VerticalAlignment
  let content: Content

  public init(
    alignment: VerticalAlignment = .center,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.alignment = alignment
    self.content = content()
  }

  public var body: some View {
    HStack(alignment: alignment, spacing: 0) {
      content
    }
  }
}

public struct VPack<Content: View>: View {
  
  let alignment: HorizontalAlignment
  let content: Content
  
  public init(
    alignment: HorizontalAlignment = .center,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.alignment = alignment
    self.content = content()
  }
  
  public var body: some View {
    VStack(alignment: alignment, spacing: 0) {
      content
    }
  }
}
