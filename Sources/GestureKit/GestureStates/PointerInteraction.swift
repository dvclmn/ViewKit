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

  /// Interesting: Unable to properly represent a Tap (press down, press up),
  /// whilst also detecting Drag (will have to think more about this), using
  /// the current method which is to handle all this in the `onChanged`
  /// of a DragGesture. So have changed to `pressing`, which is more accurate.
//  case pressing(CGPoint)
    case tap(CGPoint)

  /// This should come *already* standardised, from in the modifier
  case drag(CGRect)
  case hover(CGPoint)
  case none
}


