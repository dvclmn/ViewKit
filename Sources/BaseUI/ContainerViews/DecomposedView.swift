//
//  SubView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/6/2025.
//

import SwiftUI
import BaseHelpers

public enum SubViewType: Sendable {
  case subview
  case section
}

public struct DecomposedView<Content: View>: View {

  let subviewType: SubViewType
  let layoutType: LayoutType
  let spacing: CGFloat?
  let content: Content

  public init(
    _ subviewType: SubViewType,
    layoutType: LayoutType,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.subviewType = subviewType
    self.layoutType = layoutType
    self.spacing = spacing
    self.content = content()
  }
  
  public init(
    _ subviewType: SubViewType,
    axis: Axis?,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.init(
      subviewType,
      layoutType: LayoutType(fromAxis: axis),
      spacing: spacing,
      content: content
    )
  }

  public var body: some View {

    if #available(macOS 15, iOS 18, *) {

      Group {
        switch subviewType {

          // MARK: - SubViews
          case .subview:
            Group(subviews: content) { subviewCollection in
              DynamicStack(layoutType: layoutType, spacing: spacing) {
                SubviewContent(collection: subviewCollection, spacing: spacing)
              }
            }

          // MARK: - Sections
          case .section:
            Group(sections: content) { sectionCollection in
              DynamicStack(layoutType: layoutType, spacing: spacing) {
                SectionContent(collection: sectionCollection, spacing: spacing)
              }
            }
        }  // END switch
      } // END group
      /// This passes the axis through to the Section/Subview's `DynamicStack`
//      .environment(\.layoutAxis, axis)
      .environment(\.layoutType, layoutType)
    } else {
      // MARK: - All OS versions below macOS 15
      DynamicStack(layoutType: layoutType, spacing: spacing) {
        content
      }
    }  // END if available check
  }
}
