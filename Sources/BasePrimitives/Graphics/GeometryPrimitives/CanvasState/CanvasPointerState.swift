//
//  PointerState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/3/2026.
//

public struct PointerState: Sendable, Equatable {
  public var tap: TapState = .initial
  public var drag: DragState = .initial
  public var hover: HoverState = .initial
}

extension PointerState {
  public static let initial: Self = .init()
}
