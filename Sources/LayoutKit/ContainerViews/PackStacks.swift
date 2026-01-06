//
//  NoSpaceLayout.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

import SwiftUI

/// These were originally made to directly support Int-based
/// spacing — see `SharedHelpers` custom env value `uniSize`.
/// This caused these 'Pack' stacks to be too closely coupled
/// with `GridKit`, so they're now here simply as zero-spacing
/// container views, and I'm working on a more flexible Int-based
/// spacing thing elsewhere.

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

  let alignment: HorizontalAlignment
  let content: Content

  public init(
    _ alignment: HorizontalAlignment = .center,
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
