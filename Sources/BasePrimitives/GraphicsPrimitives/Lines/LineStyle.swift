//
//  ActionLines.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

// import ColourKit
//import CoreTools
import MetaCodable
import SwiftUI

extension ActionLine {
  /// Addresses per-line attributes. See ``ActionLine/Configuration``
  /// for attributes across the whole Action Lines canvas
  @Codable
  public struct LineStyle: Equatable, Sendable, Codable {

    public var minWidth: Double
    public var maxWidth: Double

    public var opacity: Double
    public var cycles: Double

    public var uniformity: Double

    @IgnoreCoding
    public var phaseOffset: Double = 0

    public var shape: LineShape

    public init(
      shape: LineShape,
      minWidth: Double,
      maxWidth: Double,
      opacity: Double = 1,
      cycles: CGFloat = 2,
      uniformity: Double = 1.0,
      phaseOffset: Double = 0
    ) {
      self.shape = shape
      self.minWidth = minWidth
      self.maxWidth = maxWidth
      self.opacity = opacity
      self.cycles = cycles
      self.uniformity = uniformity
      self.phaseOffset = phaseOffset
    }
  }
}

extension ActionLine.LineStyle {
  public var width: Double { (minWidth + maxWidth) / 2 }
}
