//
//  WavePath.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import SwiftUI

public struct WaveValues {
  let offsetV: CGFloat
  let offsetH: CGFloat
  let offsetR: CGFloat

  public init(v: CGFloat, h: CGFloat, r: CGFloat) {
    self.offsetV = v
    self.offsetH = h
    self.offsetR = r
  }
}
