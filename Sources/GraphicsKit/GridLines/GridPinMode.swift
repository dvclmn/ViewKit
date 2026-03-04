//
//  GridPinMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import EnumMacros

@CaseDetection
public enum GridPinMode {
  /// Pin lines to Viewport
  /// Grid lines will remain fixed in 'screen space'
  /// Panning will not affect/move grid lines.
  case viewport
  
  /// Pin lines to Pan offset
  /// Grid lines will be anchored to the pannable 'canvas'
  /// view, so panning will move the Grid Lines.
  case canvas
}
