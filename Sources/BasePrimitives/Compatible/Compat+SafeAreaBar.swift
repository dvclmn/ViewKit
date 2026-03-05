//
//  Compat+SafeAreaBar.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import SwiftUI

/// Shows the specified content as a custom bar above or below the modified view
extension View {
  @ViewBuilder
  public func safeAreaBarCompatible(
    edge: VerticalEdge,
    alignment: HorizontalAlignment = .center,
    spacing: CGFloat? = nil,
    @ViewBuilder content: () -> some View
  ) -> some View {
    if #available(macOS 26.0, iOS 26.0, *) {
      safeAreaBar(
        edge: edge,
        alignment: alignment,
        spacing: spacing,
        content: content
      )
    } else {
      overlay(
        alignment: Alignment(
          horizontal: alignment,
          vertical: edge.toAlignment
        ),
        content: content
      )
    }
  }

  @ViewBuilder
  public func safeAreaBarCompatible(
    edge: HorizontalEdge,
    alignment: VerticalAlignment = .center,
    spacing: CGFloat? = nil,
    @ViewBuilder content: () -> some View
  ) -> some View {
    if #available(macOS 26.0, iOS 26.0, *) {
      safeAreaBar(
        edge: edge,
        alignment: alignment,
        spacing: spacing,
        content: content
      )
    } else {
      overlay(
        alignment: Alignment(
          horizontal: edge.toAlignment,
          vertical: alignment
        ),
        content: content
      )
    }
  }

  //  safeAreaBar(edge: HorizontalEdge, alignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> some View) -> some View
}
