//
//  ResizeMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import Foundation

public enum ResizeMode {
  /// Fill destination rect exactly, even if aspect ratio is distorted
  case stretch
  
  /// Contain: scale uniformly to fit within destination (aspect ratio preserved)
  case fit
  
  /// Cover: scale uniformly to cover entire destination (aspect ratio preserved, may clip)
  case fill
}
