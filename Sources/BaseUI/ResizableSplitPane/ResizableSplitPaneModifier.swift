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
  @Environment(\.layoutDirection) private var layoutDirection
  @AppStorage private var storedLength: Double
  @GestureState private var dragTranslation: CGFloat = .zero
  @State private var isHandleHovered = false

  private let edge: ResizableSplitPaneEdge
  private let sizing: ResizableSplitPaneSizing
  private let handleHitPadding: CGFloat
  private let ignoredSafeAreaEdges: Edge.Set
  private let isEnabled: Bool

  init(
    storageKey: String,
    edge: Edge,
    defaultLength: CGFloat,
    lengthRange: ClosedRange<CGFloat>,
    handleHitPadding: CGFloat,
    ignoredSafeAreaEdges: Edge.Set,
    isEnabled: Bool,
    store: UserDefaults?,
  ) {
    self._storedLength = AppStorage(
      wrappedValue: Double(defaultLength),
      storageKey,
      store: store,
    )
    self.edge = ResizableSplitPaneEdge(edge)
    self.sizing = ResizableSplitPaneSizing(
      defaultLength: defaultLength,
      lengthRange: lengthRange,
    )
    self.handleHitPadding = max(.zero, handleHitPadding)
    self.ignoredSafeAreaEdges = ignoredSafeAreaEdges
    self.isEnabled = isEnabled
  }

  func body(content: Content) -> some View {
    content
      .frame(width: paneWidth, height: paneHeight)
      .overlay(alignment: edge.alignment) {
        if isEnabled {
          resizeHandle
            .offset(
              x: handleOffset.width,
              y: handleOffset.height,
            )
            .ignoresSafeArea(.container, edges: ignoredSafeAreaEdges)
        }
      }
      .zIndex(isEnabled ? 1 : 0)
  }
}

extension ResizableSplitPaneModifier {
  private var displayedLength: CGFloat {
    sizing.length(
      storedLength: storedLength,
      dragTranslation: dragTranslation,
    )
  }

  private var paneWidth: CGFloat? {
    isEnabled && edge.resizeAxis == .horizontal
      ? displayedLength
      : nil
  }

  private var paneHeight: CGFloat? {
    isEnabled && edge.resizeAxis == .vertical
      ? displayedLength
      : nil
  }

  private var handleThickness: CGFloat {
    ResizableSplitPaneSizing.dividerThickness + (handleHitPadding * 2)
  }

  private var handleOffset: CGSize {
    edge.handleOffset(
      handleThickness: handleThickness,
      layoutDirection: layoutDirection,
    )
  }

  private var resizeHandle: some View {
    Color.clear
      .frame(
        width: edge.resizeAxis == .horizontal ? handleThickness : nil,
        height: edge.resizeAxis == .vertical ? handleThickness : nil,
      )
      .contentShape(.rect)
      .overlay {
        Rectangle()
          .fill(.secondary.opacity(isHandleHovered ? 0.65 : 0.3))
          .frame(
            width: edge.resizeAxis == .horizontal
              ? ResizableSplitPaneSizing.dividerThickness
              : nil,
            height: edge.resizeAxis == .vertical
              ? ResizableSplitPaneSizing.dividerThickness
              : nil,
          )
          .allowsHitTesting(false)
      }
      .onHover { isHandleHovered = $0 }
      .pointerStyleCompatible(edge.pointerStyle)
      .gesture(resizeGesture)
      .accessibilityElement(children: .ignore)
      .accessibilityLabel("Resize pane")
      .accessibilityValue("\(Int(displayedLength.rounded())) points")
      .accessibilityAdjustableAction(adjustLength)
  }

  private var resizeGesture: some Gesture {
    DragGesture(minimumDistance: 0, coordinateSpace: .global)
      .updating($dragTranslation) { value, translation, transaction in
        transaction.animation = nil
        translation = edge.lengthTranslation(
          from: value.translation,
          layoutDirection: layoutDirection,
        )
      }
      .onEnded { value in
        storedLength = Double(
          sizing.length(
            storedLength: storedLength,
            dragTranslation: edge.lengthTranslation(
              from: value.translation,
              layoutDirection: layoutDirection,
            ),
          )
        )
      }
  }

  private func adjustLength(_ direction: AccessibilityAdjustmentDirection) {
    let translation: CGFloat

    switch direction {
      case .increment:
        translation = ResizableSplitPaneSizing.accessibilityStep
      case .decrement:
        translation = -ResizableSplitPaneSizing.accessibilityStep
      @unknown default:
        return
    }

    storedLength = Double(
      sizing.length(
        storedLength: storedLength,
        dragTranslation: translation,
      )
    )
  }
}

enum ResizableSplitPaneEdge: Equatable, Sendable {
  case top
  case leading
  case bottom
  case trailing

  init(_ edge: Edge) {
    switch edge {
      case .top:
        self = .top
      case .leading:
        self = .leading
      case .bottom:
        self = .bottom
      case .trailing:
        self = .trailing
    }
  }

  var resizeAxis: Axis {
    switch self {
      case .leading, .trailing:
        .horizontal
      case .top, .bottom:
        .vertical
    }
  }

  var alignment: Alignment {
    switch self {
      case .top:
        .top
      case .leading:
        .leading
      case .bottom:
        .bottom
      case .trailing:
        .trailing
    }
  }

  var pointerStyle: PointerStyleCompatible {
    switch resizeAxis {
      case .horizontal:
        .columnResize
      case .vertical:
        .rowResize
    }
  }

  func lengthTranslation(
    from translation: CGSize,
    layoutDirection: LayoutDirection,
  ) -> CGFloat {
    let direction = outwardDirection(layoutDirection: layoutDirection)

    return switch resizeAxis {
      case .horizontal: translation.width * direction.width
      case .vertical: translation.height * direction.height
    }
  }

  func handleOffset(
    handleThickness: CGFloat,
    layoutDirection: LayoutDirection,
  ) -> CGSize {
    let direction = outwardDirection(layoutDirection: layoutDirection)
    let distance = handleThickness / 2

    return CGSize(
      width: direction.width * distance,
      height: direction.height * distance,
    )
  }

  private func outwardDirection(
    layoutDirection: LayoutDirection
  ) -> CGSize {
    switch self {
      case .top:
        CGSize(width: 0, height: -1)
      case .leading:
        CGSize(
          width: layoutDirection == .leftToRight ? -1 : 1,
          height: 0,
        )
      case .bottom:
        CGSize(width: 0, height: 1)
      case .trailing:
        CGSize(
          width: layoutDirection == .leftToRight ? 1 : -1,
          height: 0,
        )
    }
  }
}

struct ResizableSplitPaneSizing: Equatable, Sendable {
  static let dividerThickness: CGFloat = 1
  static let accessibilityStep: CGFloat = 10

  let defaultLength: CGFloat
  let lengthRange: ClosedRange<CGFloat>

  func length(
    storedLength: Double,
    dragTranslation: CGFloat = .zero,
  ) -> CGFloat {
    let persistedLength =
      storedLength.isFinite
      ? CGFloat(storedLength)
      : defaultLength
    let proposedLength = persistedLength + dragTranslation

    return min(
      max(proposedLength, lengthRange.lowerBound),
      lengthRange.upperBound,
    )
  }
}
