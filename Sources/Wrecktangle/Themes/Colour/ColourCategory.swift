//
//  ColourCategory.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import Foundation

enum ColourCategory: String, Identifiable, Sendable {
  case primary  // Text
  case secondary  // Box frame
  case tertiary  // Invisibles
  case accent  // Subtle accents
  
  public var id: String { rawValue }
}
