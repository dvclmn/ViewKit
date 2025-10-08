//
//  SliderCustom.swift
//  Paperbark
//
//  Created by Dave Coleman on 2/11/2023.
//  Copyright © 2023 Apple. All rights reserved.
//


import SharedHelpers

import SwiftUI

/// Parts:
///
/// - Slider itself
/// - Slider label (hidden and not hidden)
/// - Haptics
/// - onEnd callback / phase
/// - Units

struct SliderCustom<Label: View>: View {
  @Environment(\.explicitHeight) private var explicitHeight
  @Environment(\.cornerRounding) private var cornerRounding
  @Environment(\.trackComponents) private var trackComponents

  @State private var isHovering: Bool = false

  @Binding var value: Double
  @Binding var store: SliderHandler
  let style: TrackFillStyle
  @ViewBuilder let label: Label

  public var body: some View {

    HStack {

      label

      GeometryReader { proxy in

        ZStack {
          // MARK: - Track
          SliderTrack(in: proxy.size)

          // MARK: - Thumb
          if trackComponents.contains(.thumb) {
            /// Slider thumb
            SliderThumb(
              //              store: $store.thumbHandler,
              //              value: value,
              position: store.thumbHandler.thumbPosition(
                forSliderValue: value,
                trackSize: store.trackSize
              ),
              shape: .circle,
            )
          }
        }  // END zstack
        .frame(maxWidth: .infinity)
        .contentShape(.rect)
        .onHover { hovering in
          isHovering = hovering
        }
        .task(id: trackHeight) {
          store.updateTrackSize(
            viewWidth: proxy.size.width,
            trackHeight: trackHeight
          )
        }
        .gesture(sliderGesture)
      }  // END geo

      /// Prevents the geo reader from taking up more space than it really needs
      .frame(height: trackHeightForFrame)
    }
  }
}

extension SliderCustom {

  var trackHeightForFrame: CGFloat {
    trackHeight + store.hitAreaBuffer
  }

  var trackHeight: CGFloat {
    explicitHeight ?? store.fallbackHeight
  }

  var sliderGesture: some Gesture {

    return DragGesture(minimumDistance: 0)
      .onChanged { gestureValue in
        value = store.handleDragChange(gestureValue)
        store.phase = .dragging
        store.didChangeSlider?(.dragging)
      }
      .onEnded { _ in
        store.phase = .idle
        store.didChangeSlider?(.idle)
      }
  }

  var clipShape: AnyShape {
    switch trackComponents {

      /// Aka has fill *only*
      case .fill:
        return AnyShape(.rect(cornerRadius: cornerRounding ?? Styles.sizeTiny))

      default:
        return AnyShape(.capsule)
    }
  }

  @ViewBuilder
  func SliderTrack(in size: CGSize) -> some View {
    ZStack {
      Rectangle()
        .fill(style.background)
        .fill(style.foreground)
    }
    .drawingGroup()
    .frame(height: trackHeight)

    .overlay(alignment: .leading) {
      if let width = store.fillWidth(for: value) {
        Rectangle()
          .fill(style.fill.opacity(isHovering ? 1.0 : 0.6))
          .frame(width: width)
      }
    }
    .clipShape(clipShape)
    .animation(Styles.animationExtraQuickNSmooth, value: isHovering)
    .position(size.midpoint)
  }

}
