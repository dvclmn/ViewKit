//
//  ShaderHandler.swift
//  Eucalypt
//
//  Created by Dave Coleman on 23/2/2024.
//

import Foundation
import SwiftUI

protocol ShaderArgumentsConvertible {
  var arguments: [Shader.Argument] { get }
}

extension ShaderArgumentsConvertible {
  static func makeArguments(_ values: Any...) -> [Shader.Argument] {
    values.map { value in
      switch value {
        case let v as CGFloat:
          return .float(v)

        case let v as Float:
          return .float(v)

        case let v as Double:
          return .float(v)

        case let v as CGPoint:
          return .float2(v.x, v.y)

        case let v as SIMD2<Float>:
          return .float2(v.x, v.y)

        case let v as [Float]:
          return .floatArray(v)

        case let v as Color:
          return .color(v)

        default:
          fatalError("Unsupported Shader.Argument type: \(type(of: value))")
      }
    }
  }
}

public struct GlitterArgs: ShaderArgumentsConvertible {
  public var origin: CGPoint
  public var spread: CGFloat

  var arguments: [Shader.Argument] {
    Self.makeArguments(origin, spread)
  }
}

public struct FisheyeArgs: ShaderArgumentsConvertible {
  public var size: CGFloat
  public var strength: CGFloat

  var arguments: [Shader.Argument] {
    Self.makeArguments(size, strength)
  }
}
