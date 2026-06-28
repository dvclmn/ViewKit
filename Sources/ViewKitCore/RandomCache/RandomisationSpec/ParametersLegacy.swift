//
//  ParametersLegacy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import Foundation

/// Backwards-compatible alias so existing call sites compile while migrating.
public typealias RandomisationParameters<T: BinaryFloatingPoint> = RandomisationSpec<T>

extension RandomisationSpec {
  /// Legacy-style initializer to ease migration from `ranges` + `additionalParams`.
  public init(
    ranges: [ClosedRange<T>] = [],
    additionalParams: [String: AnyHashable] = [:]
  ) {
    let domain: RandomDomain<T> = ranges.count == 1 ? .single(ranges[0]) : .multiple(ranges)
    var influences: [AnyInfluenceKey: AnyHashable] = [:]
    
    /// Map legacy string keys into InfluenceKey<String> for continuity.
    for (k, v) in additionalParams { influences[AnyInfluenceKey(InfluenceKey<String>(k))] = v }
    self.init(domain: domain, influences: influences)
  }
}
