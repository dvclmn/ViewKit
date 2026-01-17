//
//  StrokeHandler.swift
//  Playground
//
//  Created by Dave Coleman on 17/1/2026.
//

import Foundation

extension Array where Element == CGPoint {
  
  /// Returns a view of every `stride`-th point, always including the first.
  func sampled(every stride: Int) -> [CGPoint] {
    guard stride > 1, count > 1 else { return self }
    
    var result: [CGPoint] = []
    result.reserveCapacity(count / stride + 1)
    
    var i = 0
    while i < count {
      result.append(self[i])
      i += stride
    }
    
    // Optional: ensure last point is included
    if let last = last, result.last != last {
      result.append(last)
    }
    
    return result
  }
}

protocol PointPath {
  var points: [CGPoint] { get }
}
extension Stroke: PointPath {}
extension ActiveStroke: PointPath {}

extension PointPath {
  
  func sampledPoints(every stride: Int) -> [CGPoint] {
    points.sampled(every: stride)
  }
}
