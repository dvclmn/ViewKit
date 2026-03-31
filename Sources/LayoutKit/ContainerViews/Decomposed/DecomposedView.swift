//
//  SubView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/6/2025.
//

import BasePrimitives
import GeometryPrimitives
import SwiftUI

//#warning("USE WITH CAUTION. Causes serious performance issues for some reason, like in InfoBar")
@available(*, deprecated, message: "USE WITH CAUTION. Causes serious performance issues for some reason, like in InfoBar")
public struct DecomposedView<Content: View>: View {
  @Environment(\.layoutType) private var layoutType

  let subviewType: SubViewType
  let layoutTypeOverride: LayoutType?
  let spacing: CGFloat?
  let content: () -> Content

  /// Will fall back to environment `LayoutType` if no value provided for `layout`
  public init(
    _ subviewType: SubViewType,
    layout: LayoutType,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.subviewType = subviewType
    self.layoutTypeOverride = layout
    self.spacing = spacing
    self.content = content
  }

  public var body: some View {

    if #available(macOS 15, iOS 18, *) {

      Group {
        switch subviewType {

          // MARK: - SubViews
          case .subview:
            Group(subviews: content()) { subviewCollection in
              DynamicStack(layoutType: layoutIfPresent, spacing: spacing) {
                SubviewContent(collection: subviewCollection, spacing: spacing)
              }
            }

          // MARK: - Sections
          case .section:
            Group(sections: content()) { sectionCollection in
              DynamicStack(layoutType: layoutIfPresent, spacing: spacing) {
                SectionContent(collection: sectionCollection, spacing: spacing)
              }
            }
        }  // END switch
      }  // END group

    } else {
      // MARK: - All OS versions below macOS 15
      DynamicStack(layoutType: layoutIfPresent, spacing: spacing) {
        content()
      }
    }  // END if available check
  }
}
extension DecomposedView {
  private var layoutIfPresent: LayoutType {
    layoutTypeOverride ?? layoutType
  }
}
// MARK: - Additional inits
extension DecomposedView {
  public init(
    _ subviewType: SubViewType,
    axis: Axis?,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.init(
      subviewType,
      layout: LayoutType(fromAxis: axis.map { AlignedAxis(fromAxis: $0) }),
      spacing: spacing,
      content: content
    )
  }

}
