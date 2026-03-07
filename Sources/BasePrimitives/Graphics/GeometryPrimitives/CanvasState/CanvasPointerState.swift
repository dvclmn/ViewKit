//
//  PointerState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/3/2026.
//

//import BasePrimitives
import GestureKit

extension CanvasState {
  public struct PointerState: Sendable, Equatable {
    public var pointerTap: TapState = .init()
    public var pointerDrag: DragState = .init()
    public var pointerHover: HoverState = .init()
  }
}

extension CanvasState.PointerState {
  public static let initial: Self = .init()
}
