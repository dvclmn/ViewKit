//
//  FontCompression.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import SwiftUI
import CoreTools

struct FontCompression {
  let fontSize: CGFloat
  let cellSize: CGSize
  let zoom: CGFloat
  let zoomRange: ClosedRange<CGFloat>?
  let sensitivity: CGFloat
  let characterCount: Int
  
  /// Compute a font width, size, and visibility decision based on the available cell width and zoom.
  /// The logic progressively compresses width, slightly scales size (respecting `sensitivity`),
  /// and finally hides if even compressed text cannot fit at a legible size.
  func makeFont() -> (width: Font.Width, size: CGFloat, visible: Bool) {
    
    /// Start from a zoom-compensated size so annotation size remains perceptually stable
    let compensatedSize = fontSize.removingZoom(
      zoom,
      clampedTo: zoomRange,
      sensitivity: sensitivity
    )
    
    /// Rough average width factor for digits/ASCII in a system font
    /// This is an approximation; width compression will help when we get tight.
    let avgGlyphWidthFactor: CGFloat = 0.6
    
    /// Required width for this label at the compensated size
    /// Treat 1- and 2-digit labels equivalently to avoid distracting early compression;
    /// discriminate at 3+ digits
    let effectiveCount = max(2, characterCount)
    let requiredWidth = compensatedSize * avgGlyphWidthFactor * CGFloat(effectiveCount)
    
    /// How much horizontal room we have relative to what we'd like
    let fitRatio = cellSize.width / max(1, requiredWidth)
    
    /// Decide width first based on how tight we are
    let width: Font.Width
    switch fitRatio {
      case 1.0...:
        width = .standard
      case 0.85..<1.0:
        width = .condensed
      case 0.7..<0.85:
        width = .compressed
      default:
        /// Extremely tight — use compressed and rely on size adjustment below
        width = .compressed
    }
    
    /// Allow some size adjustment based on how tight we are, tempered by sensitivity.
    /// We cap shrinkage to 20% by default, further reduced by (1 - sensitivity).
    let rawScale = min(1.0, max(0.8, fitRatio))
    let adjustedScale = 1 - (1 - rawScale) * sensitivity
    let finalSize = compensatedSize * adjustedScale
    
    /// If we're still far from fitting, consider it not visible to avoid clutter/illegibility.
    /// Threshold chosen empirically; tweak to taste.
    let isVisible = fitRatio >= 0.5
    
    return (width, finalSize, isVisible)
  }
}
