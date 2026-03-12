//
//  CanvasTransformState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI

public struct TransformState: Sendable, Equatable {
  /// These always exist, they just return to an identity value when inactive.
  public var pan: ContinuousInteraction<CGSize> = .init(value: .zero)
  public var zoom: ContinuousInteraction<CGFloat> = .init(value: 1.0)
  public var rotation: ContinuousInteraction<Angle> = .init(value: .zero)

  public init() {}
}

extension TransformState {
  public static let initial = TransformState()

  public mutating func reset() {
    pan = .init(value: .zero)
    zoom = .init(value: 1.0)
    rotation = .init(value: .zero)
  }
}

/// Value-semantic snapshot of canvas transform interactions.
//public struct TransformState: Sendable, Equatable {
//
//  public var pan: Interaction<CGSize> = .init(value: .zero, phase: .none)
//  public var zoom: Interaction<CGFloat> = .init(value: 1.0, phase: .none)
//  public var rotation: Interaction<Angle> = .init(value: .zero, phase: .none)

//  public var panState: PanState = .initial
//  public var zoomState: ZoomState = .initial
//  public var rotationState: RotateState = .initial
//  public var latchedZoomFocusGlobal: CGPoint?
//}

//extension TransformState {
//  public static let initial: Self = .init()
//
//  public mutating func reset() {
////    panState.reset()
////    zoomState.reset()
////    rotationState.reset()
//  }
//}

//extension TransformState: ActivityDescribing {
//
//  public var activityDescription: String {
//    let panStatus = activityLabel(panState.isActive)
//    let zoomStatus = activityLabel(zoomState.isActive)
//    let rotationStatus = activityLabel(rotationState.isActive)
//
//    let panText = "Pan (\(panStatus))"
//    let zoomText = "Zoom (\(zoomStatus))"
//    let rotationText = "Rotation (\(rotationStatus))"
//
//    return [panText, zoomText, rotationText].joined(separator: ", ")
//
//  }
//}
