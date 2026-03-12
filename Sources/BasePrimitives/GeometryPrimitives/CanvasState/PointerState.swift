//
//  PointerState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/3/2026.
//

public struct PointerState: Sendable, Equatable {
  public var tapState: TapState = .init()
  public var dragState: DragState = .init(nil)
  public var hoverState: HoverState = .init()
}

extension PointerState {
  public static let initial: Self = .init()

  public mutating func reset() {
    tapState.reset()
    dragState.reset()
    hoverState.reset()
  }
}

extension PointerState: ActivityDescribing {
  public var activityDescription: String {
    let tapStatus = activityLabel(tapState.isActive)
    let dragStatus = activityLabel(dragState.isActive)
    let hoverStatus = activityLabel(hoverState.isActive)
    let tapText = "Tap (\(tapStatus))"
    let dragText = "Drag (\(dragStatus))"
    let hoverText = "Hover (\(hoverStatus))"

    return [tapText, dragText, hoverText].joined(separator: ", ")
  }
}
