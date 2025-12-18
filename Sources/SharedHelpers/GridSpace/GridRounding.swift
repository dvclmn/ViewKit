//
//  GridRounding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//


/// ## Rounding down
///
/// Fit text of known width into a number of columns:
/// Only fully contained glyphs should count
///
/// Hit-testing a click in a cell grid:
/// The “cell index” should never overflow beyond the edge.
/// `down` underestimates safely
///
/// Measuring the size of text and converting back to cell count:
/// Want an integer that represents the last fully visible cell
///
/// ## Rounding up
///
/// There are a few niche cases where
/// `.toNearestOrAwayFromZero` or `.up` might be appropriate:
///
/// 1.  Visual alignment correction
/// e.g. if your grid lines must cover all visible pixels,
/// not just the fully occupied ones.
///
/// 2.  Text measurement for expansion
/// e.g. if you’re allocating cells to fit a given string, and partial
/// overlap still needs to “reserve” space.
///
/// Read more in Bear notes:
/// bear://x-callback-url/open-note?id=81CB760B-1F34-4C93-9A5E-D6246A9E81C9
public enum GridRounding {
  case down
  case up
  
  var value: FloatingPointRoundingRule {
    switch self {
      case .down: .towardZero
      case .up: .toNearestOrAwayFromZero
    }
  }
}
