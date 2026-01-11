//
//  Interaction+Kind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import EnumMacros
import Foundation

@MetaEnum
public enum InteractionKind: Sendable {
  case tap(CGPoint)
  case drag(CGRect) // Aka tap and drag
  case tapRanges(Set<Range<Int>>)  // For multi-select
  case longPress(CGPoint)
  case gesture(GestureKind)
  case hover(CGPoint)
  case none

}
