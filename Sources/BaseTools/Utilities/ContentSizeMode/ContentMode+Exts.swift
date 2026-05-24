//
//  ContentMode+CGSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI
import ViewTools

//import BasePrimitives

extension CGSize {
  public func aspectRatio(
    mode: ContentSizeMode,
    intoSize size: CGSize,
    insets: EdgeInsets = .zero,
  ) -> CGSize {
    // Guard against degenerate sizes
    if isZero || size.isZero { return .zero }

    // aspectRatio is defined as height/width for the content size
    let contentAspect = self.height / self.width

    return mode.size(
      for: size,
      aspectRatio: contentAspect,
      insets: insets,
    )
  }
}

extension CGPoint {
  public func mapPoint(
    from source: CGRect,
    to destination: CGRect,
    mode: ContentSizeMode = .fit,
  ) -> CGPoint {
    switch mode {
      case .stretch: stretchMap(from: source, to: destination)
      case .fit: aspectFitMap(from: source, to: destination)
      case .fill: aspectFillMap(from: source, to: destination)
      case .fixed: fatalError("Not yet supported")
    }
  }

  private func aspectFitMap(from source: CGRect, to destination: CGRect) -> CGPoint {
    let fittedRect = aspectMappedRect(from: source, to: destination, fill: false)
    return stretchMap(from: source, to: fittedRect)
  }

  private func aspectFillMap(from source: CGRect, to destination: CGRect) -> CGPoint {
    let filledRect = aspectMappedRect(from: source, to: destination, fill: true)
    return stretchMap(from: source, to: filledRect)
  }

  private func aspectMappedRect(
    from source: CGRect,
    to destination: CGRect,
    fill: Bool,
  ) -> CGRect {
    let sourceAspect = source.width / source.height
    let destAspect = destination.width / destination.height

    var scale: CGFloat
    var size: CGSize
    var origin: CGPoint

    if (fill && sourceAspect < destAspect) || (!fill && sourceAspect > destAspect) {
      // Width-constrained
      scale = destination.width / source.width
      size = CGSize(width: destination.width, height: source.height * scale)
      origin = CGPoint(
        x: destination.minX,
        y: destination.minY + (destination.height - size.height) / 2,
      )
    } else {
      // Height-constrained
      scale = destination.height / source.height
      size = CGSize(width: source.width * scale, height: destination.height)
      origin = CGPoint(
        x: destination.minX + (destination.width - size.width) / 2,
        y: destination.minY,
      )
    }

    return CGRect(origin: origin, size: size)
  }

  private func stretchMap(from source: CGRect, to destination: CGRect) -> CGPoint {
    let scaleX = destination.width / source.width
    let scaleY = destination.height / source.height

    let translatedX = (self.x - source.minX) * scaleX + destination.minX
    let translatedY = (self.y - source.minY) * scaleY + destination.minY

    return CGPoint(x: translatedX, y: translatedY)
  }
}
