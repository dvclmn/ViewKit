//
//  TapDragPhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/8/2025.
//

import Foundation
import CoreTools

/// Note: Could consider creating a type to encapsulate
/// the `CGPoint`/`CGRect` overlaps, for Taps/Drags.
@CaseDetection
@AssociatedValues
public enum TapDragPhase: Equatable, Sendable {
  case drag(rect: CGRect)
  case tap(location: CGPoint)
  case ended
}
