//
//  PointerState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/3/2026.
//

import CoreGraphics
import Foundation

/// Example payload for the drag state
/// ```
/// public struct DragData: Sendable, Equatable {
///   public var startLocation: CGPoint
///   public var currentLocation: CGPoint
///   public var translation: CGSize {
///     CGSize(
///       width: currentLocation.x - startLocation.x,
///       height: currentLocation.y - startLocation.y
///     )
///   }
/// }
/// ```
public struct PointerState: Sendable, Equatable {
  /// These only exist when they are happening.
  public var tap: TransientInteraction<CGPoint?> = .init()
  public var hover: TransientInteraction<CGPoint?> = .init()

  /// Drag data usually needs an origin and a translation/current point.
  //  public var drag: TransientInteraction<CGRect> = .init()
  public var drag: TransientInteraction<DragData> = .init()
}

public struct DragData: Sendable, Equatable {
  public var startLocation: CGPoint
  public var currentLocation: CGPoint
}

extension DragData {
  public var translation: CGSize {
    CGSize(
      width: currentLocation.x - startLocation.x,
      height: currentLocation.y - startLocation.y
    )
  }
}

//public struct PointerState: Sendable, Equatable {
//  public var tapState: TapState = .init()
//  public var dragState: DragState = .init(nil)
//  public var hoverState: HoverState = .init()
//
//  public var tap: Interaction<CGPoint> = .init(value: .zero, phase: .none)
//  public var drag: Interaction<CGFloat> = .init(value: 1.0, phase: .none)
//  public var hover: Interaction<Angle> = .init(value: .zero, phase: .none)
//}
//
//extension PointerState {
//  public static let initial: Self = .init()
//
//  public mutating func reset() {
//    tapState.reset()
//    dragState.reset()
//    hoverState.reset()
//  }
//}

//extension PointerState: ActivityDescribing {
//  public var activityDescription: String {
//    let tapStatus = activityLabel(tapState.isActive)
//    let dragStatus = activityLabel(dragState.isActive)
//    let hoverStatus = activityLabel(hoverState.isActive)
//    let tapText = "Tap (\(tapStatus))"
//    let dragText = "Drag (\(dragStatus))"
//    let hoverText = "Hover (\(hoverStatus))"
//
//    return [tapText, dragText, hoverText].joined(separator: ", ")
//  }
//}
