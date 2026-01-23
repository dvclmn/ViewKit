//
//  EnvironmentResolvable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

public protocol EnvironmentResolvableColour {
  var toColour: Color { get }
  
  init(
    colour: Color,
    environment: EnvironmentValues,
    name: String?
  )
  
  init(
    resolved: Color.Resolved,
    name: String?
  )
}
