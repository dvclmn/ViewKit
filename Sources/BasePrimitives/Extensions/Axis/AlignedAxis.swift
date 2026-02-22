//
//  AlignedAxis.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

import SwiftUI

/// For times when I want to specify an Alignment alongside an Axis
/// Meant to correspond to SwiftUI's H/VStack alignments
public enum AlignedAxis {
  case horizontal(VerticalAlignment)
  case vertical(HorizontalAlignment)
  
}
