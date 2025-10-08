//
//  ShadowView.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 15/11/2024.
//


import SwiftUI

public struct StageView: View {

  let floorConfig: FloorAppearance
  let viewSize: CGSize

  public init(
    floorConfig: FloorAppearance = .init(),
    viewSize: CGSize
  ) {
    self.floorConfig = floorConfig
    self.viewSize = viewSize
  }

  public var body: some View {

    PatternCanvas(.checkerboard, config: floorConfig.pattern)

      //      .opacity(floorConfig.opacity)

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

      .scaleEffect(x: floorConfig.width, y: floorConfig.depth, anchor: .center)

      .mask {
        ZStack {
          LinearGradient(
            colors: [.black, .clear],
            startPoint: .bottom,
            endPoint: .center
          )
          .mask {
            RadialGradient(
              colors: [.black, .clear],
              center: .center,
              startRadius: viewSize.width * 0.3,
              endRadius: viewSize.width * 0.65
            )
          }
        }
      }  // END mask
      .drawingGroup()
  }
}

//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  StageView(floorConfig: .init(), viewSize: .trackpad)
//}
//#endif
