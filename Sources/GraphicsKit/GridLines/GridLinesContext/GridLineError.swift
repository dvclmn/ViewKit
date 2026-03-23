//
//  GridLineError.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/3/2026.
//

import Foundation

enum GridLineError: Error, LocalizedError {
  case missingEnvUnitSize
  case missingEnvGridDimensions
  
  var errorDescription: String? {
    switch self {
      case .missingEnvUnitSize:
        return "Missing unitSize"
      case .missingEnvGridDimensions:
        return "Missing gridDimensions"
    }
  }
}
