//
//  Model+StrokePoint.swift
//  Playground
//
//  Created by Dave Coleman on 19/1/2026.
//

import Foundation

public typealias Points = [PointStyle: CGPoint]

public struct PointStyle: Hashable {
  let colour: RGBColour
  let radius: CGFloat
}

struct StrokePoint {
  let point: CGPoint
}

