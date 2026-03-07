//
//  SurroundSpacing.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import Foundation

public enum SurroundSpaces: Sendable, Hashable {
  /// Never insert extra "bookend" spaces.
  case none
  
  /// Add one space before and after the whole text (only applies when not splitting).
  case aroundWholeText
  
  /// Add one space on either side of each gap (only applies when splitting).
  case aroundSplitGaps
  
  /// Apply both rules depending on mode (whole text when not splitting, gaps when splitting).
  case both
}
