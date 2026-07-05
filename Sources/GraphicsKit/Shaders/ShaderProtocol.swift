//
//  ShaderProtocol.swift
//  ViewKit
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI

public struct OscillatingPoint {
  var time: TimeInterval
  var amplitude: CGFloat
  
//  var arguments: () -> [Shader.Argument]
}

extension OscillatingPoint {
  var arguments: [Shader.Argument] {
    [.float(time), .float(amplitude)]
  }
}
