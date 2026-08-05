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
  private let ignoredSafeAreaEdges: Edge.Set
  private let isEnabled: Bool

  init(
    storageKey: String,
    defaultWidth: CGFloat,
    widthRange: ClosedRange<CGFloat>,
    handleHitPadding: CGFloat,
    ignoredSafeAreaEdges: Edge.Set,
    isEnabled: Bool,
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
    self.ignoredSafeAreaEdges = ignoredSafeAreaEdges
    self.isEnabled = isEnabled
  }

  func body(content: Content) -> some View {
    content
      .frame(width: isEnabled ? displayedWidth : nil)
      .overlay(alignment: .trailing) {
        if isEnabled {
          resizeHandle
            .offset(x: handleWidth / 2)
            .ignoresSafeArea(.container, edges: ignoredSafeAreaEdges)
        }
      }
      .zIndex(isEnabled ? 1 : 0)
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
    let persistedWidth =
      storedWidth.isFinite
      ? CGFloat(storedWidth)
      : defaultWidth
    let proposedWidth = persistedWidth + dragTranslation

    return min(
      max(proposedWidth, widthRange.lowerBound),
      widthRange.upperBound,
    )
  }
}
