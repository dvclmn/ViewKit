//
//  CaseFallback.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import Foundation
import BasePrimitives
import MacroHelpers

public enum CaseFallbackStrategy<Root: MetaEnum> {
  
  /// Do not switch; keep the underlying value as-is and keep `selectedMeta` aligned to it.
  /// This s the “safe default”, and matches what the UI should do. Selection
  /// shouldn’t claim a case you can’t represent.
  case keepCurrent
  
  /// Switch only if a fallback value can be produced.
  /// Useful for app-specific defaults like `.graphics(.actionLines)`.
  /// This is how you express “sensible defaults” without hard-coding anything into the handler.
  case fallbackValue((Root.Meta) -> Root?)
  
  /// Treat missing construction as a programmer error.
  /// Handy in dev builds when you believe every meta should be constructible or cached.
  case assertAndKeepCurrent(message: @autoclosure () -> String = "Unable to switch meta case")
}
