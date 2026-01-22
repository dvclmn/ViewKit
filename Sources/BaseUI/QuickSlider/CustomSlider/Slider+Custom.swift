//
//  SliderCustom.swift
//  Paperbark
//
//  Created by Dave Coleman on 2/11/2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import BasePrimitives
import SwiftUI

/// Parts:
///
/// - Slider itself
/// - Slider label (hidden and not hidden)
/// - Haptics
/// - onEnd callback / phase
/// - Units

struct SliderCustom: View {
//struct SliderCustom<Label: View>: View {
  @Environment(\.explicitHeight) private var explicitHeight
  @Environment(\.cornerRounding) private var cornerRounding
  @Environment(\.sliderComponents) private var sliderComponents
  @Environment(\.sliderHandler) private var store

  @State private var isHovering: Bool = false

  let style: TrackFillStyle

//  @ViewBuilder let label: Label

  public var body: some View {

//    HStack {
//      label

      GeometryReader { proxy in
        ZStack {
          // MARK: - Track
          SliderTrack(in: proxy.size)

          // MARK: - Thumb
          if sliderComponents.contains(.thumb) {
            /// Slider thumb
            SliderThumb(
              //              store: $store.thumbHandler,
              //              value: value,
              position: store.thumbHandler.thumbPosition(
                forSliderValue: store.value,
                range: store.range,
                trackSize: store.trackSize
              ),
              shape: .circle,
            )
          }
        }  // END zstack
        .frame(maxWidth: .infinity)
        .contentShape(.rect)
        .onHover { isHovering = $0 }

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
//    }
//    .frame(maxWidth: .infinity)
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
        store.value = store.handleDragChange(gestureValue)
        store.updatePhase(.dragging)
      }
      .onEnded { _ in
        store.updatePhase(.idle)
      }
  }

  var clipShape: AnyShape {
    switch sliderComponents {

      /// Aka has fill *only*
      case .track: AnyShape(.rect(cornerRadius: cornerRounding ?? Styles.sizeTiny))
      default: AnyShape(.capsule)
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
      if let width = store.fillWidth() {
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
