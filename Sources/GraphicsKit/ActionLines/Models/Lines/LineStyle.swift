//
//  ActionLines.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import ColourKit
import CoreTools
import SwiftUI

extension ActionLine {
  /// Addresses per-line attributes. See ``ActionLine/Configuration``
  /// for attributes across the whole Action Lines canvas
  public struct LineStyle: Equatable, Sendable, Codable {

    public var minWidth: Double
    public var maxWidth: Double

    public var opacity: Double
    public var cycles: Double

    public var shape: LineShape

    public init(
      shape: LineShape,
      minWidth: Double,
      maxWidth: Double,
      opacity: Double = 1,
      cycles: CGFloat = 2,
    ) {
      self.shape = shape
      self.minWidth = minWidth
      self.maxWidth = maxWidth
      self.opacity = opacity
      self.cycles = cycles
    }
  }
}

extension ActionLine.LineStyle {
  public var width: Double { (minWidth + maxWidth) / 2 }
}
