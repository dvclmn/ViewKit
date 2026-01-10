//
//  String+Split.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

public struct SplitConfig {
  public var separator: Character
  public var emptyPolicy: EmptyFieldPolicy = .structuralOnly
  public var trailingPolicy: TrailingPolicy = .keepAll
  public var trimWhitespace: Bool = true

  public init(
    separator: Character,
    emptyPolicy: EmptyFieldPolicy = .structuralOnly,
    trailingPolicy: TrailingPolicy = .keepAll,
    trimWhitespace: Bool = true
  ) {
    self.separator = separator
    self.emptyPolicy = emptyPolicy
    self.trailingPolicy = trailingPolicy
    self.trimWhitespace = trimWhitespace
  }
}

public enum EmptyFieldPolicy {
  /// Drop fields that are structurally empty (from `||`, leading/trailing separators).
  case structuralOnly

  /// Drop fields that become empty after trimming/normalising.
  case semantic

  /// Keep everything.
  case keepAll
}

/// Optional post-processing applied *after* splitting.
public enum TrailingPolicy {
  case keepAll
  case dropIfEmptyAfterTrim
}

/// Example usage:
///
/// ```
/// let cells = line.split(using: .init(
///   separator: "|",
///   emptyPolicy: .semantic
/// ))
///
/// let lines = text.split(using: .init(
///   separator: "\n",
///   emptyPolicy: .keepAll,
///   trailingPolicy: .dropIfEmptyAfterTrim
/// ))
///
/// ```
extension String {
  public func split(
    at separator: Character,
    emptyPolicy: EmptyFieldPolicy = .structuralOnly,
    trailingPolicy: TrailingPolicy = .keepAll,
    trimWhitespace: Bool = true
  ) -> [String] {
    let config = SplitConfig(
      separator: separator,
      emptyPolicy: emptyPolicy,
      trailingPolicy: trailingPolicy,
      trimWhitespace: trimWhitespace
    )
    return self.split(using: config)
  }
  
  public func split(
    using config: SplitConfig
  ) -> [String] {
    /// 1. Structural split
    let raw = self.split(
      separator: config.separator,
      omittingEmptySubsequences: config.emptyPolicy == .structuralOnly
    )

    /// 2. Content normalisation
    var fields = raw.map { substring in
      config.trimWhitespace
        ? substring.trimmingCharacters(in: .whitespaces)
        : String(substring)
    }

    /// 3. Semantic filtering
    switch config.emptyPolicy {
      case .semantic:
        fields.removeAll { $0.isEmpty }
      case .structuralOnly, .keepAll:
        break
    }

    /// 4. Trailing rule
    if case .dropIfEmptyAfterTrim = config.trailingPolicy {
      if let last = fields.last, last.isEmpty {
        fields.removeLast()
      }
    }

    return fields
  }
}
