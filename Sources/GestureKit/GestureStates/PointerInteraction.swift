//
//  PointerInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools

@MetaEnum
@CaseDetection(includesNames: true)
public enum PointerInteraction {

  /// Tap doesn't have a phase, like Drag/Hover do
  /// Mostly geared towards triggering an event
  case tap(CGPoint)

  /// This CGRect should arrive here *already* standardised
  case drag(CGRect, InteractionPhase)
  
  /// Doesn't require an explicit phase; phase is inferred
  /// from the presence of a value. Nil == .ended
  case hover(CGPoint?)
}
