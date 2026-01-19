//
//  ScrubberElastic.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CoreTools

enum RangePhase: Equatable {
  case idle
  case nearBoundary(HorizontalBoundary, proximity: Double)
  case overshooting(HorizontalBoundary, distance: Double)
}
extension RangePhase {
  func phase(
    value: Double,
    range: ClosedRange<Double>?,
    isDragging: Bool
  ) -> RangePhase {
    guard let range else { return .idle }

    let rangeLength: Double = range.length
    let absoluteBuffer = 2.0
    let relativeBuffer = rangeLength * 0.08
    let buffer = max(absoluteBuffer, relativeBuffer)

    let lowerDelta = value - range.lowerBound
    let upperDelta = range.upperBound - value

    let result: RangePhase = {
      if lowerDelta < 0 {
        return .overshooting(.leading, distance: lowerDelta)
      }
      if upperDelta < 0 {
        return .overshooting(.trailing, distance: upperDelta)
      }

      if lowerDelta < buffer {
        return .nearBoundary(.leading, proximity: 1 - lowerDelta / buffer)
      }
      if upperDelta < buffer {
        return .nearBoundary(.trailing, proximity: 1 - upperDelta / buffer)
      }

      return .idle
    }()

    
  }

}

enum HorizontalBoundary {
  case leading
  case trailing
}
