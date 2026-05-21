//
//  CommonKeys.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import Foundation

extension InfluenceKey where Value == Double {
  /// Bias/skew factor in the range [-1, 1], where 0 is uniform.
  public static var skew: InfluenceKey<Double> { "skew" }
}

extension InfluenceKey where Value == Bool {
  /// Whether to favor continuity between successive values.
  public static var smoothTransitions: InfluenceKey<Bool> { "smoothTransitions" }
}
extension InfluenceKey where Value == CGFloat {
  /// Canonical roughness influence for rough path/stroke generation.
  public static var roughness: InfluenceKey<CGFloat> { "roughness" }
  /// Canonical jitter influence for rough path/stroke generation.
  public static var jitter: InfluenceKey<CGFloat> { "jitter" }
}
