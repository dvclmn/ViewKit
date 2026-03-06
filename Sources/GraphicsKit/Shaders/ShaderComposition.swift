//
//  ShaderComposition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI
import BasePrimitives

public protocol AnyShaderEffect {
  var shaders: [Shader] { get }
  var id: String { get }
  var name: String { get }
}

extension ShaderEffect: AnyShaderEffect {
  public var shaders: [Shader] { [shader] }
  public var name: String { reference.name }
}

public struct CompositeEffect: AnyShaderEffect, Sendable, Hashable, Identifiable {
  public var effects: [ShaderEffect]

  public var shaders: [Shader] { effects.map(\.shader) }
  public var id: String { effects.map(\.id).joined(separator: " > ") }
  public var name: String { effects.map(\.name).joined(separator: " → ") }

  public init(_ effects: [ShaderEffect]) { self.effects = effects }
}

public enum ShaderComposition: Sendable, Codable, Hashable, Identifiable {
  case single(ShaderEffect)
  case sequence([ShaderEffect])

  public var id: String {
    switch self {
      case .single(let effect): effect.id
      case .sequence(let effects): effects.map(\.id).joined(separator: " > ")
    }
  }

  public var name: String {
    switch self {
      case .single(let effect): effect.name
      case .sequence(let effects): effects.map(\.name).joined(separator: " → ")
    }
  }

  public var shaders: [Shader] {
    switch self {
      case .single(let effect): [effect.shader]
      case .sequence(let effects): effects.map { $0.shader }
    }
  }
}
