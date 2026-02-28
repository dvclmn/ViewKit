//
//  Canvas+Environment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 8/7/2025.
//

import SwiftUI

extension EnvironmentValues {
//  @Entry public var canvasGeometry: CanvasGeometry = .init()
//  @Entry public var canvasSize: CGSize = .zero
  @Entry public var isResizingCanvas: Bool = false

  
  
//  @Entry public var pointerState: PointerState = .initial
//  @Entry public var tapLocation: CGPoint?

//  @Entry public var dragRect: CGRect?
  
  @Entry public var shouldRenderDragRect: Bool = true
//  @Entry public var pointerInteraction: PointerInteraction.Meta = .none
//  @Entry public var isHoverEnabled: Bool = true
//  @Entry public var isDragEnabled: Bool = true
}
