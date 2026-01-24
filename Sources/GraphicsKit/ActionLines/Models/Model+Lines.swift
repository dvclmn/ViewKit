//
//  ActionLines.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import ColourKit
import SwiftUI
import CoreTools

extension ActionLine {
  public struct Style: Equatable {
    
    public var minWidth: Double
    public var maxWidth: Double
//    public var lineWidthRange: ClosedRange<Double>
//    public var width: Double
    
//    public var width: Double
    public var blendMode: BlendMode
    public var opacity: Double
    
    public var shape: LineShape

    public init(
      shape: LineShape,
      minWidth: Double,
      maxWidth: Double,
      blendMode: BlendMode = .normal,
      opacity: Double = 1
    ) {
      self.shape = shape
      self.minWidth = minWidth
      self.maxWidth = maxWidth
      self.blendMode = blendMode
      self.opacity = opacity
    }
    
    public init(
      shape: LineShape,
      width: Double,
      blendMode: BlendMode = .normal,
      opacity: Double = 1
    ) {
      self.init(
        shape: shape,
        minWidth: width,
        maxWidth: width,
        blendMode: blendMode,
        opacity: opacity
      )
    }
    
    public init(
      shape: LineShape,
      lineWidthRange: ClosedRange<Double>,
      blendMode: BlendMode = .normal,
      opacity: Double = 1
    ) {
      self.init(
        shape: shape,
        minWidth: lineWidthRange.lowerBound,
        maxWidth: lineWidthRange.upperBound,
        blendMode: blendMode,
        opacity: opacity
      )
    }
  }
}

extension ActionLine.Style {

  
//  public var minWidth: Double { lineWidthRange.lowerBound }
//  public var maxWidth: Double { lineWidthRange.upperBound }
  public var width: Double { (minWidth + maxWidth) / 2 }
  
}

@CaseDetection
public enum LineShape: String, CaseIterable, Identifiable {
  case triangle
  case diamond
  case wave // Add values here later
  
  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }
}
