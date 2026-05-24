//
//  SubviewContent.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/6/2025.
import CoreTools
import ViewTools
import SwiftUI

@available(macOS 15.0, iOS 18.0, *)
public struct SubviewContent: View {
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.layoutType) private var layoutType

  let collection: SubviewsCollection
  let spacing: CGFloat?
  public var body: some View {

    ForEach(subviews: collection) { subview in
      DynamicStack(
        layoutType: layoutType,
        spacing: (spacing ?? layoutSpacing).subElementSpacingReduction()
      ) {
        subview
        /// Display a divider, as dictated by the `ContainerValue`
        /// This expresses; "All subviews except for the last one"
        if subview.containerValues.hasDividers, !subview.isLastInCollection(collection) {
          ContainerDivider()
        }
      }
    }  // END foreach
  }
}
