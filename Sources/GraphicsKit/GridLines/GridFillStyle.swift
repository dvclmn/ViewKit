//
//  GridFillStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import Foundation

/// `fill(size: CGSize)` is ambiguous about which size, or what size means
///
/// Should probably clarify, or be specific at call sites;
/// - Passing a `containerSize`, means “grid that fills the viewport”.
/// - Passing a `contentSize`, means “grid that matches the content extent”.
///
/// For “always fill the current container”, could maybe also try
/// ```
/// case fillContainer
/// case fill(size: CGSize)
///
/// ```
public enum GridFillStyle {
  case fixed(columns: Int, rows: Int)
  case fill(size: CGSize)
}
