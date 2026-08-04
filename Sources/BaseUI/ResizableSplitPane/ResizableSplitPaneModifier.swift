//
//  ResizableSplitPaneModifier.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/8/2026.
//

import Foundation
import SwiftUI
import ViewTools

struct ResizableSplitPaneModifier: ViewModifier {
  @AppStorage private var storedWidth: Double
  @GestureState private var dragTranslation: CGFloat = .zero
  @State private var isHandleHovered = false

  private let sizing: ResizableSplitPaneSizing
  private let handleHitPadding: CGFloat

  init(
    storageKey: String,
    defaultWidth: CGFloat,
    widthRange: ClosedRange<CGFloat>,
    handleHitPadding: CGFloat,
    store: UserDefaults?,
  ) {
    self._storedWidth = AppStorage(
      wrappedValue: Double(defaultWidth),
      storageKey,
      store: store,
    )
    self.sizing = ResizableSplitPaneSizing(
      defaultWidth: defaultWidth,
      widthRange: widthRange,
    )
    self.handleHitPadding = max(.zero, handleHitPadding)
  }

  func body(content: Content) -> some View {
    content
      .frame(width: displayedWidth)
      .overlay(alignment: .trailing) {
        resizeHandle
          .offset(x: handleWidth / 2)
      }
      .zIndex(1)
  }
}

extension ResizableSplitPaneModifier {
  private var displayedWidth: CGFloat {
    sizing.width(
      storedWidth: storedWidth,
      dragTranslation: dragTranslation,
    )
  }

  private var handleWidth: CGFloat {
    ResizableSplitPaneSizing.dividerWidth + (handleHitPadding * 2)
  }

  private var resizeHandle: some View {
    Color.clear
      .frame(width: handleWidth)
      .contentShape(.rect)
      .overlay {
        Rectangle()
          .fill(.secondary.opacity(isHandleHovered ? 0.65 : 0.3))
          .frame(width: ResizableSplitPaneSizing.dividerWidth)
          .allowsHitTesting(false)
      }
      .onHover { isHandleHovered = $0 }
      .pointerStyleCompatible(.columnResize)
      .gesture(resizeGesture)
      .accessibilityElement(children: .ignore)
      .accessibilityLabel("Resize pane")
      .accessibilityValue("\(Int(displayedWidth.rounded())) points")
      .accessibilityAdjustableAction(adjustWidth)
  }

  private var resizeGesture: some Gesture {
    DragGesture(minimumDistance: 0, coordinateSpace: .global)
      .updating($dragTranslation) { value, translation, transaction in
        transaction.animation = nil
        translation = value.translation.width
      }
      .onEnded { value in
        storedWidth = Double(
          sizing.width(
            storedWidth: storedWidth,
            dragTranslation: value.translation.width,
          )
        )
      }
  }

  private func adjustWidth(_ direction: AccessibilityAdjustmentDirection) {
    let translation: CGFloat

    switch direction {
      case .increment:
        translation = ResizableSplitPaneSizing.accessibilityStep
      case .decrement:
        translation = -ResizableSplitPaneSizing.accessibilityStep
      @unknown default:
        return
    }

    storedWidth = Double(
      sizing.width(
        storedWidth: storedWidth,
        dragTranslation: translation,
      )
    )
  }
}

struct ResizableSplitPaneSizing: Equatable, Sendable {
  static let dividerWidth: CGFloat = 1
  static let accessibilityStep: CGFloat = 10

  let defaultWidth: CGFloat
  let widthRange: ClosedRange<CGFloat>

  func width(
    storedWidth: Double,
    dragTranslation: CGFloat = .zero,
  ) -> CGFloat {
    let persistedWidth = storedWidth.isFinite
      ? CGFloat(storedWidth)
      : defaultWidth
    let proposedWidth = persistedWidth + dragTranslation

    return min(
      max(proposedWidth, widthRange.lowerBound),
      widthRange.upperBound,
    )
  }
}

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
    store: UserDefaults? = nil,
  ) -> some View {
    modifier(
      ResizableSplitPaneModifier(
        storageKey: storageKey,
        defaultWidth: defaultWidth,
        widthRange: widthRange,
        handleHitPadding: handleHitPadding,
        store: store,
      )
    )
  }
}
