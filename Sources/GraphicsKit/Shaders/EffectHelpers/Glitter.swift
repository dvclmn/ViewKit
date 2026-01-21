//
//  Glitter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//


public struct GlitterArgs: ShaderArgumentsConvertible {
  public var origin: CGPoint
  public var spread: CGFloat
  
  var arguments: [Shader.Argument] {
    Self.makeArguments(origin, spread)
  }
}
