//
//  Repeater.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import LayoutKit
import SwiftUI

public struct Repeater<Content: View>: View {

  let count: Int
  let axis: Axis?
  let spacing: CGFloat?
  let content: Content

  public init(
    _ count: Int,
    axis: Axis? = nil,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.count = count
    self.axis = axis
    self.spacing = spacing
    self.content = content()
  }

  public var body: some View {

    DynamicStack(axis: axis, spacing: spacing) {
      ForEach(0..<self.count, id: \.self) { _ in
        content
      }
    }
  }
}
