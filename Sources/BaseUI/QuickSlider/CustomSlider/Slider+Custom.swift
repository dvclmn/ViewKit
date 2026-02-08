//
//  SliderCustom.swift
//  Paperbark
//
//  Created by Dave Coleman on 2/11/2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import CoreTools
import SwiftUI

/// Parts:
///
/// - Slider itself
/// - Slider label (hidden and not hidden)
/// - Haptics
/// - onEnd callback / phase
/// - Units

extension QuickSlider {
  struct SliderCustom: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.cornerRounding) private var cornerRounding
    @Environment(\.sliderComponents) private var sliderComponents

    @State private var isHovering: Bool = false

    @Binding var value: Value
    let thumbDiameter: Value = 16
    let style: TrackStyle

    public var body: some View {

      Capsule()
        .fill(.brown)
        .viewSize(
          capture: .size,
          mode: .debounce(0.2),
          isEnabled: true,
          valueOutput: { size in
            store.trackWidth = size.width
          }
        )
        .overlay {
          // MARK: - Track
          SliderTrackBackground(style: style)
            .environment(\.isHovering, isHovering)
        }
        //    GeometryReader { proxy in
        //      ZStack {
        //        // MARK: - Track
        //        SliderTrackBackground(
        //          style: style,
        //          height: trackHeight,
        //        )
        //        .environment(\.isHovering, isHovering)
        //
        //        // MARK: - Thumb
        //        if sliderComponents.contains(.thumb) {
        //
        //          /// Slider thumb
        //          SliderThumb(
        //            diameter: thumbDiameter,
        //            position: store.thumbPosition(
        //              value: value.toDouble,
        //              diameter: thumbDiameter.toDouble,
        //              trackSize: store.trackSize
        //            ),
        //            shape: .circle,
        //          )
        //        }
        //      }  // END zstack
        //      .frame(maxWidth: .infinity)
        //      .contentShape(.rect)
        //      .onHover { isHovering = $0 }
        //
        //      .task(id: trackHeight) {
        //        store.updateTrackSize(
        //          viewWidth: proxy.size.width,
        //          trackHeight: trackHeight
        //        )
        //      }
        //      .gesture(sliderGesture)
        //    }  // END geo

        .frame(height: store.trackHeightWithBuffer)
    }
  }
}

extension QuickSlider.SliderCustom {

  var sliderGesture: some Gesture {

    return DragGesture(minimumDistance: 0)
      .onChanged { gestureValue in
        guard let new = store.handleDragChange(gestureValue) else { return }
        value = Value(new)
        store.updatePhase(.dragging)
      }
      .onEnded { _ in
        store.updatePhase(.idle)
      }
  }

  //  @ViewBuilder
  //  func SliderTrack(in size: CGSize) -> some View {
  //    ZStack {
  //      Rectangle()
  //        .fill(style.background)
  //        .fill(style.foreground)
  //    }
  //    .drawingGroup()
  //    .frame(height: trackHeight)
  //
  //    .overlay(alignment: .leading) {
  //      if let width = store.fillWidth() {
  //        Rectangle()
  //          .fill(style.fill.opacity(isHovering ? 1.0 : 0.6))
  //          .frame(width: width)
  //      }
  //    }
  //    .clipShape(clipShape)
  //    .animation(Styles.animationExtraQuickNSmooth, value: isHovering)
  //    .position(size.midpoint)
  //  }

}
