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

    //    @Environment(\.sliderTrackStyle) private var trackStyle

    // or however you compose the track view

    @State private var isHovering: Bool = false

    @Binding var value: Double
    let track: TrackBackground
    //    let style: TrackStyle

    public var body: some View {

      Capsule()
        //        .fill(.cyan.opacity(0.2))
        .fill(.clear)
        .viewSize(
          capture: .size,
          mode: .debounce(0.2),
          isEnabled: true,
          valueOutput: { size in
            store.trackWidth = size.width
          }
        )

        .overlay {

          //          trackStyle.makeBody(configuration: config)
          //            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))

                    ZStack {
                      // MARK: - Track
    track()
//                      SliderTrackBackground(style: style)
                        .environment(\.isHovering, isHovering)
          
                      // MARK: - Thumb
                      if sliderComponents.contains(.thumb),
                        let position = store.thumbPosition(value: value.toDouble)
                      {
          
                        /// Slider thumb
                        SliderThumb(
                          diameter: store.thumbDiameter,
                          shape: .circle,
                        )
                        .position(position)
                      }
                    }
        }
        .onHover { isHovering = $0 }
        .frame(height: store.trackHeightWithBuffer)
        .gesture(sliderGesture)
    }
  }
}

extension QuickSlider.SliderCustom {

  //    let trackConfig = SliderTrackConfiguration(
  //      value: normalizedValue,
  //      range: 0...1,
  //      isEnabled: isEnabled,
  //      orientation: .horizontal,
  //      size: proposedSize,
  //      colorScheme: colorScheme,
  //      tint: tintColor
  //    )

  var sliderGesture: some Gesture {

    return DragGesture(minimumDistance: 0)
      .onChanged { gestureValue in
        guard let new = store.handleDragChange(gestureValue) else { return }
        value = new
        store.updatePhase(.dragging)
      }
      .onEnded { _ in
        store.updatePhase(.idle)
      }
  }
}
