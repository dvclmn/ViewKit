//
//  WaveStyle.swift
//  BaseDemos
//
//  Created by Dave Coleman on 27/1/2026.
//

//// import ColourKit
import CoreTools
import Foundation

public struct WaveStyle: Codable, Sendable, Equatable, Hashable {
  public var lineStyle: WaveLineStyle
  public var pointStyle: PointStyle

  public init(
    line: WaveLineStyle = .init(),
    point: PointStyle = .init(),
  ) {
    self.lineStyle = line
    self.pointStyle = point
  }
}
