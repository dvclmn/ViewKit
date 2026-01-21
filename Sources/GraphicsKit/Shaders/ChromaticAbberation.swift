//
//  ChromaticAbberation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import SwiftUI

public struct ChromaticAberrationArgs: ShaderArgumentsConvertible {
  public var red: CGFloat
  public var blue: CGFloat
  public var strength: CGFloat

  var arguments: [Shader.Argument] {
    Self.makeArguments(red, blue, strength)
  }
}
