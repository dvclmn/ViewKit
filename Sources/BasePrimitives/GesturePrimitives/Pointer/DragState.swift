//
//  DragState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/3/2026.
//

import Foundation

public struct DragState: PointerStateProtocol, Activatable {
  public var value: CGRect?
  public var isActive: Bool = false
  
  public let dragThreshold: CGFloat = 6
  
  public init(_ value: Value? = nil) {
    self.value = value
  }
}
