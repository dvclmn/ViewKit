//
//  DynamicLayout.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/5/2025.
//

import BaseHelpers
import SwiftUI

/// Will only 'have layout' (e.g. H or VStack) if an `axis` is supplied,
/// either via the init, or via the environment. If axis is nil, this
/// is essentially a 'pass-through' view.
public struct DynamicStack<Content: View>: View {
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.layoutSpacing) private var layoutSpacing

//  let axis: Axis?
  let layoutType: LayoutType
  let spacing: CGFloat?
  let content: Content

  public init(
    layoutType: LayoutType,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.layoutType = layoutType
    self.spacing = spacing
    self.content = content()
  }
  
  public init(
    axis: Axis?,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.init(
      layoutType: LayoutType(fromAxis: axis),
      spacing: spacing,
      content: content
    )
  }


  public var body: some View {

    if let layout = layoutType.toLayout(spacing: spacing ?? layoutSpacing) {
      layout {
        content
      }
    } else {
      content
    }

  }
}

