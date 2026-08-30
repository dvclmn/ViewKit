//
//  InfoBar+ViewExts.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import SwiftUI

extension View {
  /// Presents one InfoBar and makes it available to contributing descendants.
  ///
  /// Place this modifier as high in the hierarchy as the participating views require.
  /// Descendants contribute content with `infoBarValue`, `infoBarItem`, or the existing
  /// `infoBarItems` APIs.
  @MainActor
  public func infoBarView(isEnabled: Bool = true) -> some View {
    modifier(
      InfoBarModifier(isEnabled: isEnabled)
    )
  }

  /// Presents one InfoBar with custom content before its contributed items.
  ///
  /// Leading content appears first in the bar's horizontally scrolling sequence;
  /// it isn't pinned to the physical leading edge.
  ///
  /// Leading content is declared at the presenter and isn't registered through
  /// `InfoBarStore`. It inherits environment values available at this modifier;
  /// environment values installed only by descendants don't flow back into it.
  @MainActor
  public func infoBarView<LeadingContent: View>(
    isEnabled: Bool = true,
    @ViewBuilder leadingContent: () -> LeadingContent,
  ) -> some View {
    modifier(
      InfoBarModifier(
        isEnabled: isEnabled,
        leadingContent: leadingContent,
      )
    )
  }

  /// Presents one InfoBar with custom content after its contributed items.
  ///
  /// Trailing content appears last in the bar's horizontally scrolling sequence;
  /// it isn't pinned to the physical trailing edge.
  ///
  /// Trailing content is declared at the presenter and isn't registered through
  /// `InfoBarStore`. It inherits environment values available at this modifier;
  /// environment values installed only by descendants don't flow back into it.
  @MainActor
  public func infoBarView<TrailingContent: View>(
    isEnabled: Bool = true,
    @ViewBuilder trailingContent: () -> TrailingContent,
  ) -> some View {
    modifier(
      InfoBarModifier(
        isEnabled: isEnabled,
        trailingContent: trailingContent,
      )
    )
  }

  /// Presents one InfoBar with custom content before and after its contributed items.
  ///
  /// Both content closures are declared at the presenter and aren't registered through
  /// `InfoBarStore`. They inherit environment values available at this modifier;
  /// environment values installed only by descendants don't flow back into them.
  @MainActor
  public func infoBarView<LeadingContent: View, TrailingContent: View>(
    isEnabled: Bool = true,
    @ViewBuilder leadingContent: () -> LeadingContent,
    @ViewBuilder trailingContent: () -> TrailingContent,
  ) -> some View {
    modifier(
      InfoBarModifier(
        isEnabled: isEnabled,
        leadingContent: leadingContent,
        trailingContent: trailingContent,
      )
    )
  }
}
