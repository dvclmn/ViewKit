//
//  PointerState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/3/2026.
//

public struct PointerState: Sendable, Equatable {
  public var tap: TapState = .init()
  public var drag: DragState = .init()
  public var hover: HoverState = .init()
}

extension PointerState {
  public static let initial: Self = .init()
}
