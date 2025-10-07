//
//  SubviewContent.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/6/2025.
//

import BaseHelpers
import SwiftUI
import SharedHelpers

@available(macOS 15.0, iOS 18.0, *)
public struct SectionContent: View {
  @Environment(\.layoutAxis) private var layoutAxis
  @Environment(\.layoutType) private var layoutType
  @Environment(\.layoutSpacing) private var layoutSpacing

  let collection: SectionCollection
  let spacing: CGFloat?
  public var body: some View {

    /// `sectionConfig` allows us to target and style discrete parts
    /// of the section from here, without needing to crowd the View
    /// holding the sections themselves.
    ///
    /// Subview equivalent:
    /// `ForEach(subviews: subviewCollection) { subview in`
    ForEach(collection) { sectionElement in

      if sectionElement.containerValues.isShowingSectionHeader {
        sectionElement.header
          .foregroundStyle(.secondary.opacity(0.8))
          .fontWeight(.medium)
      }

      /// This second/nested `DynamicStack` (in addition to the stack
      /// in `DecomposedView`) is here to allow more control over
      /// layout *within* each section.
      DynamicStack(layoutType: layoutType, spacing: (spacing ?? layoutSpacing).subElementSpacingReduction()) {
        sectionElement.content
      }

      sectionElement.footer

      if sectionElement.containerValues.hasDividers {
        ContainerDivider()
      }

      if sectionElement.containerValues.hasSpacers {
        Spacer()
          .frame(height: Styles.sizeRegular.bump)
      }

    }  // END for each
  }
}
