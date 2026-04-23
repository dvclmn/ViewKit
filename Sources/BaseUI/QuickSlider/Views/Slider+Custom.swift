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
extension QuickSlider {
  struct SliderCustom: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.cornerRounding) private var cornerRounding
    @Environment(\.sliderComponents) private var sliderComponents
    @Environment(\.colorScheme) private var colourScheme

    @State private var isHovering: Bool = false

    @Binding var value: Double
    let track: TrackBody

    public var body: some View {

      Capsule()
        .fill(.clear)
        .viewSize(
          capture: .size,
          mode: .debounce(0.2),
          isEnabled: true,
          valueOutput: { size in
            store.trackWidth = size.width
          },
        )

        .overlay {
          TrackView()
          ThumbView()

        }
        .onHover { isHovering = $0 }
        .frame(height: store.trackHeightWithBuffer)
        .gesture(sliderGesture)
    }
  }
}

extension QuickSlider.SliderCustom {

  @ViewBuilder
  private func TrackView() -> some View {
    track
      .frame(height: store.trackHeight)
      .clipShape(clipShape)
      .environment(\.isHovering, isHovering)
  }

  @ViewBuilder
  private func ThumbView() -> some View {
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

  var clipShape: AnyShape {
    switch sliderComponents {

      /// Aka has fill *only*
      case .track: AnyShape(.rect(cornerRadius: cornerRounding ?? Styles.sizeTiny))
      default: AnyShape(.capsule)
    }
  }
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
