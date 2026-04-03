//
//  ContentMode+CGSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI
import InteractionKit

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

    //    return thing
    //    switch mode {
    //    case .stretch:
    //      // Ignore aspect ratio, stretch to fill destination
    //      return size
    //
    //    case .fit:
    //      // Uniformly scale to fit within destination
    //      let widthBased = CGSize(width: size.width, height: size.width * contentAspect)
    //      if widthBased.height <= size.height {
    //        return widthBased
    //      } else {
    //        return CGSize(width: size.height / contentAspect, height: size.height)
    //      }
    //
    //    case .fill:
    //      // Uniformly scale to cover destination (may clip)
    //      let containerAspect = size.height / size.width
    //      if containerAspect > contentAspect {
    //        // Container taller than content → match height
    //        return CGSize(width: size.height / contentAspect, height: size.height)
    //      } else {
    //        // Container wider than content → match width
    //        return CGSize(width: size.width, height: size.width * contentAspect)
    //      }
    //
    //    case .fixed(let length, let axis):
    //      // Fix one axis length, derive the other from aspect ratio (h/w)
    //      switch axis {
    //      case .horizontal:
    //        let width = length
    //        let height = length * contentAspect
    //        return CGSize(width: width, height: height)
    //      case .vertical:
    //        let height = length
    //        let width = length / contentAspect
    //        return CGSize(width: width, height: height)
    //      }
    //    }
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
