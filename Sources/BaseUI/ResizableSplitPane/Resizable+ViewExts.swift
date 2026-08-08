//
//  Resizable+ViewExts.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/8/2026.
//

import SwiftUI

extension View {
  /// Makes this view resizable from one edge in a split layout.
  ///
  /// The selected edge determines whether the view receives an explicit width or height,
  /// where the resize handle appears, and which drag direction increases the view's size.
  /// Place the modified view in an `HStack` or `VStack` with zero spacing so the handle
  /// lies on the shared boundary with an adjacent pane.
  ///
  /// - Parameters:
  ///   - storageKey: The User Defaults key used to persist the pane length.
  ///   - edge: The boundary edge that the resize handle controls.
  ///   - defaultLength: The width or height used until a persisted value exists.
  ///   - lengthRange: The inclusive limits applied to persisted and interactive lengths.
  ///   - handleHitPadding: Invisible hit padding on each side of the one-point divider.
  ///   - ignoredSafeAreaEdges: Safe-area edges ignored by the resize handle.
  ///   - isEnabled: Whether the explicit length and resize handle are active.
  ///   - store: The User Defaults store. Pass a suite or app-group store when required.
  public func resizableSplitPane(
    _ storageKey: String,
    edge: Edge,
    defaultLength: CGFloat,
    lengthRange: ClosedRange<CGFloat> = 100...600,
    handleHitPadding: CGFloat = 8,
    ignoredSafeAreaEdges: Edge.Set = [],
    isEnabled: Bool = true,
    store: UserDefaults? = nil,
  ) -> some View {
    modifier(
      ResizableSplitPaneModifier(
        storageKey: storageKey,
        edge: edge,
        defaultLength: defaultLength,
        lengthRange: lengthRange,
        handleHitPadding: handleHitPadding,
        ignoredSafeAreaEdges: ignoredSafeAreaEdges,
        isEnabled: isEnabled,
        store: store,
      )
    )
  }

  /// Makes this view the leading, horizontally resizable pane in a split layout.
  ///
  /// This convenience is equivalent to selecting the view's trailing edge with
  /// ``resizableSplitPane(_:edge:defaultLength:lengthRange:handleHitPadding:ignoredSafeAreaEdges:isEnabled:store:)``.
  @available(*, deprecated, renamed: "resizableSplitPane(_:edge:defaultLength:lengthRange:handleHitPadding:ignoredSafeAreaEdges:isEnabled:store:)")
  public func resizableSplitPane(
    _ storageKey: String,
    defaultWidth: CGFloat,
    widthRange: ClosedRange<CGFloat> = 100...600,
    handleHitPadding: CGFloat = 8,
    ignoredSafeAreaEdges: Edge.Set = [],
    isEnabled: Bool = true,
    store: UserDefaults? = nil,
  ) -> some View {
    resizableSplitPane(
      storageKey,
      edge: .trailing,
      defaultLength: defaultWidth,
      lengthRange: widthRange,
      handleHitPadding: handleHitPadding,
      ignoredSafeAreaEdges: ignoredSafeAreaEdges,
      isEnabled: isEnabled,
      store: store,
    )
  }
}
