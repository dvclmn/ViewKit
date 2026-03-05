//
//  QuickLabel+Role.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import SwiftUI
//import SampleBuilder

//@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
public enum ActionRole: Equatable, Sendable, Codable, Hashable {
  case success
  case destructive
  case error
  case warning
  case neutral

  public var colour: Color? {
    switch self {
      case .success: .green
      case .destructive: .red
      case .error: .red
      case .warning: .yellow
      case .neutral: nil
    }
  }
}
