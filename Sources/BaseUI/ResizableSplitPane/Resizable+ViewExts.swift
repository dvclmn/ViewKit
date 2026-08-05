//
//  Resizable+ViewExts.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/8/2026.
//

import SwiftUI

extension View {
  /// Makes this view the leading, horizontally resizable pane in a split layout.
  ///
  /// Place the modified view first in an `HStack` with zero spacing. The view receives
  /// an explicit width, while its siblings retain the `HStack`'s normal layout behaviour.
  /// The resolved width is persisted in User Defaults when a resize gesture ends.
  ///
  /// - Parameters:
  ///   - storageKey: The User Defaults key used to persist the pane width.
  ///   - defaultWidth: The width used until a persisted value exists.
  ///   - widthRange: The inclusive limits applied to persisted and interactive widths.
  ///   - handleHitPadding: Invisible hit padding on each side of the one-point divider.
  ///   - store: The User Defaults store. Pass a suite or app-group store when required.
  public func resizableSplitPane(
    _ storageKey: String,
    defaultWidth: CGFloat,
    widthRange: ClosedRange<CGFloat> = 100...600,
    handleHitPadding: CGFloat = 8,
    ignoredSafeAreaEdges: Edge.Set = [],
    isEnabled: Bool = true,
    store: UserDefaults? = nil,
  ) -> some View {
    modifier(
      ResizableSplitPaneModifier(
        storageKey: storageKey,
        defaultWidth: defaultWidth,
        widthRange: widthRange,
        handleHitPadding: handleHitPadding,
        ignoredSafeAreaEdges: ignoredSafeAreaEdges,
        isEnabled: isEnabled,
        store: store,
      )
    )
  }
}
