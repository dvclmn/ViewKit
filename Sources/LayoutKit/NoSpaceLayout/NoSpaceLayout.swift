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
    _ alignment: VerticalAlignment = .center,
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
  
  @Environment(\.unitSize) private var unitSize
  
  let alignment: HorizontalAlignment
  let gridSpacing: Int
  let content: Content
  
  public init(
    _ alignment: HorizontalAlignment = .center,
    _ spacing: Int = 0,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.alignment = alignment
    self.gridSpacing = spacing
    self.content = content()
  }
  
  public var body: some View {
    VStack(alignment: alignment, spacing: gridSpacing.toScreenLength(along: .vertical, using: unitSize)) {
      content
    }
  }
}
