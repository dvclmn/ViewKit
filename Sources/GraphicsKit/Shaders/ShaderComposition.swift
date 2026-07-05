//
//  ShaderComposition.swift
//  ViewKit
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

public enum ShaderComposition: Sendable, Codable, Hashable, Identifiable {
  case single(ShaderEffect)
  case sequence([ShaderEffect])

  public var id: String {
    switch self {
      case .single(let effect): effect.id
      case .sequence(let effects): effects.map(\.id).joined(separator: " > ")
    }
  }

  public var displayName: String {
    switch self {
      case .single(let effect): effect.displayName
      case .sequence(let effects): effects.map(\.displayName).joined(separator: " → ")
    }
  }

  public var effects: [ShaderEffect] {
    switch self {
      case .single(let effect): [effect]
      case .sequence(let effects): effects
    }
  }

  public var shaders: [Shader] {
    effects.map(\.shader)
  }
}
