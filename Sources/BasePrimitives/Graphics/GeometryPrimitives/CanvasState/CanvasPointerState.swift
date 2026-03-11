//
//  PointerState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/3/2026.
//

public struct PointerState: Sendable, Equatable {
  public var tap: TapState = .init()
  public var drag: DragState = .init(nil)
  public var hover: HoverState = .init()
}

extension PointerState {
  public static let initial: Self = .init()

  public mutating func reset() {
    tap.reset()
    drag.reset()
    hover.reset()
  }
}
extension PointerState {
  private func activityLabel(_ isActive: Bool) -> String { isActive ? "active" : "idle" }

  public var activityDescription: String {
    let tapStatus = activityLabel(tap.isActive)
    let dragStatus = activityLabel(drag.isActive)
    let hoverStatus = activityLabel(hover.isActive)

    let tapText = "Tap (\(tapStatus))"
    let dragText = "Drag (\(dragStatus))"
    let hoverText = "Hover (\(hoverStatus))"

    return [tapText, dragText, hoverText].joined(separator: ", ")
  }
}

