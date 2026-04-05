//
//  GridLineContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import BasePrimitives
import BaseTools
import SwiftUI

// MARK: - Main Context
struct GridLineContext {
  let unitSize: CGSize
  let gridRect: GridRect
  let containerSize: CGSize
  let sizeMode: GridSizeMode
  let pinMode: GridPinMode
  let lineWidth: CGFloat
  let drawsBorder: Bool
  let panOffset: CGSize
  let zoomLevel: CGFloat
  let zoomRange: ClosedRange<CGFloat>?
  let hasCellNumbers: Bool
}

extension GridLineContext {
  init(
    domain: GridFontDomain,
    containerSize: CGSize,
    sizeMode: GridSizeMode,
    pinMode: GridPinMode,
    drawsBorder: Bool,
    environment: EnvironmentValues
  ) throws {
    let unitSize = domain.unitSize(in: environment)
    let dimensions = environment.gridDimensions
    
    guard let unitSize else {
//      printMissing("unitSize", for: "GridLineContext")
      throw GridLineError.missingEnvUnitSize
//      return nil
    }
    guard let dimensions else {
//      printMissing("dimensions", for: "GridLineContext")
      throw GridLineError.missingEnvGridDimensions
    }

    self.unitSize = unitSize
    self.containerSize = containerSize
    self.sizeMode = sizeMode
    self.pinMode = pinMode
    self.lineWidth = environment.gridLineWidth
    self.drawsBorder = drawsBorder
    self.panOffset = environment.panOffset
    self.zoomLevel = environment.zoomLevel.toCGFloat
    self.zoomRange = environment.zoomRange?.toCGFloatRange
    self.hasCellNumbers = environment.isShowingCellNumbers
    self.gridRect = GridRect(origin: .zero, size: dimensions)
  }
}

struct GridLineAnnotation {
  let text: String
  let point: CGPoint
}

struct GridLineOutput {
  let path: Path
  let lineWidth: CGFloat
  let annotations: [GridLineAnnotation]
}
