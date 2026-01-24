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
  public struct Style: Equatable, Sendable, Codable {

    public var minWidth: Double
    public var maxWidth: Double
    
//    public var blendMode: BlendMode
    public var opacity: Double
    
    /// This is for wave only
    public var sampleCount: Int
    public var cycles: CGFloat

    public var shape: LineShape

    public init(
      shape: LineShape,
      minWidth: Double,
      maxWidth: Double,
//      blendMode: BlendMode = .normal,
      opacity: Double = 1,
      sampleCount: Int = 30,
      cycles: CGFloat = 2,
    ) {
      self.shape = shape
      self.minWidth = minWidth
      self.maxWidth = maxWidth
//      self.blendMode = blendMode
      self.opacity = opacity
      self.sampleCount = sampleCount
      self.cycles = cycles
    }

//    public init(
//      shape: LineShape,
//      width: Double,
//      blendMode: BlendMode = .normal,
//      opacity: Double = 1
//    ) {
//      self.init(
//        shape: shape,
//        minWidth: width,
//        maxWidth: width,
//        blendMode: blendMode,
//        opacity: opacity
//      )
//    }
//
//    public init(
//      shape: LineShape,
//      lineWidthRange: ClosedRange<Double>,
//      blendMode: BlendMode = .normal,
//      opacity: Double = 1
//    ) {
//      self.init(
//        shape: shape,
//        minWidth: lineWidthRange.lowerBound,
//        maxWidth: lineWidthRange.upperBound,
//        blendMode: blendMode,
//        opacity: opacity
//      )
//    }
  }
}

extension ActionLine.Style {
  public var width: Double { (minWidth + maxWidth) / 2 }

}

@CaseDetection
public enum LineShape: String, CaseIterable, Identifiable, Sendable, Codable {
  case triangle
  case diamond
  case wave  // Add values here later

  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }
  public var icon: String {
    switch self {
      case .triangle: "triangle"
      case .diamond: "diamond"
      case .wave: "water.waves"
    }
  }
}
