//
//  GraphicsContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

extension BinaryFloatingPoint {
  func removingZoomPercent(_ zoomPercent: Self) -> Self {
    let result = Double(self) / pow(1 + Double(zoomPercent), 1)
    return Self(result)
  }
}
//extension String {
//  public var firstLine: String {
//    let firstSubstring = self.split(separator: "\n").first ?? ""
//    return String(firstSubstring)
//  }
//}

@available(macOS 14.0, *)
extension GraphicsContext {

  // MARK: - Quick Text Label, w/ Background and Dot
  /// Note: This relies on the zoom level passed to `zoomPercent` being already
  /// normalised / expressed as a percentage. Aka range-indepedant.
  ///
  /// Otherwise changing the zoom range in the caller domain will have
  /// unintended effects on font size calculations
  public func drawDebugText(
    _ text: String,
    at point: CGPoint,
    positioned debugTextPosition: DebugTextPosition = .aboveOrigin,
    colour: Color = .primary,
    fontSize: CGFloat = 11,
    pointDisplay: DebugPoint,
    zoomPercent zoomLevel: CGFloat?  // Pass in normalised zoom if relevant
  ) {

    let zoom = zoomLevel ?? 1.0
    let fontSizeUnZoomed = fontSize.removingZoomPercent(zoom)

    /// Calculate size, for drawing Label background
    let labelWidthUnZoomed: CGFloat = {
      let approximateCharacterWidth: CGFloat = fontSize * 0.7
      let labelCharacterWidth = CGFloat(text.firstLine.count) * approximateCharacterWidth
      return labelCharacterWidth.removingZoomPercent(zoom)
    }()
    
    let labelHeightUnZoomed: CGFloat = fontSizeUnZoomed * 1.5
    let labelSize = CGSize(width: labelWidthUnZoomed, height: labelHeightUnZoomed)

    /// Set up Text, with basic styles
    let text = Text(text)
      .font(.system(size: fontSizeUnZoomed, weight: .semibold))
      .foregroundStyle(colour)

    let labelRect = CGRect(
      origin: point.centredIn(size: labelSize).shifted(
        dx: 0, dy: (labelHeightUnZoomed * 1.2) * debugTextPosition.multiplierForYPosition),
      size: labelSize
    )
//    self.fill(labelRect.path, with: .color(Color.gray))
    self.draw(text, at: labelRect.midpoint)

    /// Draw dot at provided point, if needed
    if let pointColour = pointDisplay.colourForPoint {
      self.drawCircleCentred(at: point, colour: pointColour)
    }
  }

  // MARK: - Centered Circle
  public func drawCircleCentred(
    at origin: CGPoint,
    size: CGFloat = 6,
    colour: Color = .blue
  ) {
    //    let circleOrigin = origin.aligned(to: .center, in: CGSize(fromLength: size))
    let circleOrigin = origin.shifted(by: -(size / 2))
    let circleRect = CGRect(origin: circleOrigin, size: CGSize(fromLength: size))
    self.fill(.init(ellipseIn: circleRect), with: .color(colour))
  }

  // MARK: - Quick Fill and Stroke
  public func fillAndStroke(
    _ path: Path,
    fillColour: Color = .blue.opacity(0.4),
    strokeColour: Color = .indigo,
    strokeThickness: CGFloat = 1
  ) {
    self.fill(
      path,
      with: .color(fillColour)
    )
    self.stroke(
      path,
      with: .color(strokeColour),
      lineWidth: strokeThickness
    )
  }

  public func drawHorizonLine(
    in size: CGSize,
    colour: Color = .gray,
    strokeStyle: StrokeStyle? = nil,
    strokeWidth: CGFloat = 2
  ) {

    let stroke = strokeStyle ?? StrokeStyle.dashed(strokeWidth: strokeWidth)
    let rect = CGRect(origin: .zero, size: size)
    let midY = rect.midY
    let baselinePath = Path { p in
      p.move(to: CGPoint(x: rect.minX, y: midY))
      p.addLine(to: CGPoint(x: rect.maxX, y: midY))
    }
    self.stroke(
      baselinePath,
      with: .color(colour),
      style: stroke
    )
  }

  // MARK: - Dashed Stroke
  public func dashedStroke(
    _ path: Path,
    colour: Color,
    strokeWidth: CGFloat,
    style: StrokeDashStyle = .dots,
    gap: CGFloat = 3,
  ) {
    self.stroke(
      path,
      with: .color(colour),
      style: StrokeStyle.dashed(strokeWidth: strokeWidth, style: style, gap: gap)
    )
  }
}
