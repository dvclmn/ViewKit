//
//  WaveStyle.swift
//  BaseDemos
//
//  Created by Dave Coleman on 27/1/2026.
//

import ColourKit
import CoreTools
import Foundation

public typealias FloatWaveStyle = WaveStyle<Double>
//public typealias FloatWaveStyle = WaveStyle<Float>

public struct WaveStyle<T: WaveFloat>: Codable, Sendable, Equatable, Hashable {
  public var lineStyle: FloatLineStyle
  public var pointStyle: FloatPointStyle

  public init(
    line: FloatLineStyle = .init(),
    point: FloatPointStyle = .init(),
  ) {
    self.lineStyle = line
    self.pointStyle = point
  }
}

//extension WaveStyle {
//  public init() {
//    
//  }
//}
