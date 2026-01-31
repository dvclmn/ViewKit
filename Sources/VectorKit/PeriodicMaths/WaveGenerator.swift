//
//  WaveGenerator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/1/2026.
//

import SwiftUI

public struct WaveGenerator {
  var points: [CGPoint] = []
  var path: Path = .init()
  var interpolation: WaveInterpolation = .linear
}
