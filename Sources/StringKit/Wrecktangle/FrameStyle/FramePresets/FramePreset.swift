//
//  FramePreset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

extension Box {
  public enum FramePreset: String, Sendable, Codable, Hashable {
    case single
    case double
    case horizontals
    case notebook
  }
}

extension Box.FramePreset {
  
  var name: String { rawValue.capitalized }
  var frame: Box.FrameStructure {
    switch self {
      case .single: Frame.single
      case .double: Frame.double
      case .horizontals: Frame.horizontals
      case .notebook: fatalError("The Notebook style is not yet implemented.")
    }
  }
}
