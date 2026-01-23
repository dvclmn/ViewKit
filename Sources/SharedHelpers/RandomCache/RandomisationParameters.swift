//
//  RandomisationParameters.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation

/// A container for parameters that influence random value generation.
///
/// This structure holds both numeric ranges and additional parameters that may affect
/// the random generation process.
public struct RandomisationParameters: Hashable {
  
  /// Ranges that define the bounds for random value generation.
  public var ranges: [ClosedRange<Double>]
  
  /// Additional parameters that may influence the random generation process.
  public var additionalParams: [String: AnyHashable]
  
  /// Creates a new instance of randomisation parameters.
  /// - Parameters:
  ///   - ranges: Array of closed ranges defining bounds for random values.
  ///   - additionalParams: Dictionary of named parameters that may influence generation.
  public init(
    ranges: [ClosedRange<Double>] = [],
    additionalParams: [String: AnyHashable] = [:]
  ) {
    self.ranges = ranges
    self.additionalParams = additionalParams
  }
}
