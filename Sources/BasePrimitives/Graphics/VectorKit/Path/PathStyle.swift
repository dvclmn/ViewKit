//
//  PathStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

//import CasePaths
import BasePrimitives
import SwiftUI

/// Path style with optional stamping effect
public struct PathStyle: Sendable, Codable, Hashable {
  let interpolation: WaveInterpolation
  let stamped: PointStyle?
}

extension PathStyle {

  public static let line: Self = .init(
    interpolation: .linear,
    stamped: nil
  )

  public static let smooth: Self = .init(
    interpolation: .quadratic(),
    stamped: nil
  )

  public static let lineStamped: Self = .init(
    interpolation: .linear,
    stamped: PointStyle(shape: .circle, radius: 3.0)
  )

  public static func stamped(
    shape: PointShape,
    radius: Double,
    interpolation: WaveInterpolation = .quadratic()
  ) -> Self {
    Self.init(
      interpolation: interpolation,
      stamped: .init(
        shape: shape,
        radius: radius,
      )
    )
  }
}
