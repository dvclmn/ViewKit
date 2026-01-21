//
//  FishEye.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import SwiftUI

public struct FisheyeArgs: ShaderArgumentsConvertible {
  public var size: CGFloat
  public var strength: CGFloat

  var arguments: [Shader.Argument] {
    Self.makeArguments(size, strength)
  }
}
