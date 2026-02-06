//
//  ShadowView.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 15/11/2024.
//

import CoreTools
import SwiftUI

public struct StageView: View {
  @Environment(\.viewportSize) private var viewportSize
  let floorConfig: FloorAppearance

  /// Optional override to the environment view size
  let viewSize: CGSize?

  public init(
    floorConfig: FloorAppearance = .init(),
    viewSize: CGSize? = nil
  ) {
    self.floorConfig = floorConfig
    self.viewSize = viewSize
  }

  public init(
    pattern: PatternPreset,
    viewSize: CGSize? = nil
  ) {
    self.floorConfig = FloorAppearance(pattern: pattern)
    self.viewSize = viewSize
  }

  public var body: some View {

    ZStack {
      PatternCanvas(floorConfig.pattern.style, config: floorConfig.pattern.config)

        /// This `rotation3DEffect` is dedicated to driving the Yaw only
        .rotation3DEffect(
          .degrees(floorConfig.yaw),
          axis: (x: 0, y: 0, z: 1),
          anchor: .center,
          anchorZ: 0,
          perspective: 0
        )

        /// - Parameters:
        ///   - angle: The angle by which to rotate the view's content.
        ///   - axis: The axis of rotation, specified as a tuple with named
        ///     elements for each of the three spatial dimensions.
        ///   - anchor: A two dimensional unit point within the view about which to
        ///     perform the rotation. The default value is ``UnitPoint/center``.
        ///   - anchorZ: The location on the z-axis around which to rotate the
        ///     content. The default is `0`.
        ///   - perspective: The relative vanishing point for the rotation. The
        ///     default is `1`.
        .rotation3DEffect(
          .degrees(floorConfig.degrees),
          /// Keeping `y` at `0` — I want the horizon to stay flat.
          axis: (x: 1, y: 0, z: 0),
          anchor: .center,
          anchorZ: floorConfig.zoom,
          perspective: floorConfig.perspective
        )

    }
    .compositingGroup()

    .scaleEffect(x: floorConfig.width, y: floorConfig.depth, anchor: .center)

    //      .mask {

    //        ZStack {
    //          LinearGradient(
    //            colors: [.black, .clear],
    //            startPoint: .bottom,
    //            endPoint: .center
    //          )
    //          .mask {
    //            RadialGradient(
    //              colors: [.black, .clear],
    //              center: .center,
    //              startRadius: sizeOfView.width * 0.3,
    //              endRadius: sizeOfView.width * 0.65
    //            )
    //          }
    //        }
    //      }  // END mask
    //      .drawingGroup()
    //      .debugTextOverlay("No viewport size", isEnabled: noViewSizeProvided)
  }
}

extension StageView {
  private var noViewSizeProvided: Bool { viewSize == nil && viewportSize == nil }
  private var sizeOfView: CGSize? { viewSize ?? viewportSize }
}

#if DEBUG
#Preview {
  StageView()
    .frame(width: 400, height: 680)
}
#endif
