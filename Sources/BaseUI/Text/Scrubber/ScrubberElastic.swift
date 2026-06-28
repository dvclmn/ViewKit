//
//  ScrubberElastic.swift
//  ViewKit
//
//  Created by Dave Coleman on 19/1/2026.
//


enum HorizontalBoundary {
  case leading
  case trailing
}

enum RangePhase: Equatable {
  case idle
  case nearBoundary(HorizontalBoundary, proximity: Double)
  case overshooting(HorizontalBoundary, distance: Double)
}
extension RangePhase {

  static func phase(
    value: Double,
    range: ClosedRange<Double>?,
    isDragging: Bool
  ) -> RangePhase {

    guard
      isDragging,
      let range
    else {
      return .idle
    }

    let rangeLength = range.upperBound - range.lowerBound

    /// Bail out if the range is too small to be meaningful
    guard rangeLength > 0 else {
      return .idle
    }

    let absoluteBuffer = 2.0
    let relativeBuffer = rangeLength * 0.08
    let buffer = max(absoluteBuffer, relativeBuffer)

    let lowerDelta = value - range.lowerBound
    let upperDelta = range.upperBound - value

    if lowerDelta < 0 {
      return .overshooting(.leading, distance: abs(lowerDelta))
    }

    if upperDelta < 0 {
      return .overshooting(.trailing, distance: abs(upperDelta))
    }

    if lowerDelta < buffer {
      let proximity = 1 - (lowerDelta / buffer)
      return .nearBoundary(.leading, proximity: proximity.clamped(to: 0...1))
    }

    if upperDelta < buffer {
      let proximity = 1 - (upperDelta / buffer)
      return .nearBoundary(.trailing, proximity: proximity.clamped(to: 0...1))
    }

    return .idle
  }
}
//  func phase(
//    value: Double,
//    range: ClosedRange<Double>?,
//    isDragging: Bool
//  ) -> RangePhase {
//    guard let range else { return .idle }
//
//    let rangeLength: Double = range.length
//    let absoluteBuffer = 2.0
//    let relativeBuffer = rangeLength * 0.08
//    let buffer = max(absoluteBuffer, relativeBuffer)
//
//    let lowerDelta = value - range.lowerBound
//    let upperDelta = range.upperBound - value
//
//    let result: RangePhase = {
//      if lowerDelta < 0 {
//        return .overshooting(.leading, distance: lowerDelta)
//      }
//      if upperDelta < 0 {
//        return .overshooting(.trailing, distance: upperDelta)
//      }
//
//      if lowerDelta < buffer {
//        return .nearBoundary(.leading, proximity: 1 - lowerDelta / buffer)
//      }
//      if upperDelta < buffer {
//        return .nearBoundary(.trailing, proximity: 1 - upperDelta / buffer)
//      }
//
//      return .idle
//    }()
//
//
//  }

//}
