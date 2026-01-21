//
//  Model+Wave.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 3/11/2024.
//

import SwiftUI

/// `cyclesAcross` is a bit like a Wave 'zoom level'. How much
/// of the Wave we see in a View's width. Does not effect
/// the outputted wave `value` at all.
public struct WaveAppearance: Sendable, Codable {
  //  let path: PathConfiguration
  let lineWidth: CGFloat
  let pathStyle: PathStyle
  //  let points: PointStyle
  let cyclesAcross: CGFloat

  static var windowOptions: [CGFloat] { [1, 2, 4, 8, 12, 24, 30] }
  static var timeRange: ClosedRange<CGFloat> { 1...30 }

  public init(
    lineWidth: CGFloat = 2.0,
    pathStyle: PathStyle = .smooth,
    //    path: PathConfiguration = .init(),
    //    points: PointStyle = .init(),
    cyclesAcross: CGFloat = 2
  ) {
    self.lineWidth = lineWidth
    self.pathStyle = pathStyle
    self.cyclesAcross = cyclesAcross
  }
}

//public struct PathConfiguration {
//  let lineWidth: CGFloat
//  //  let strokeStyle: StrokeStyle
//  //  let smoothing: PathSmoothing
//
//  public init(
//    lineWidth: CGFloat = 1
//      //    strokeStyle: StrokeStyle = .init(lineWidth: 1),
//      //    smoothing: PathSmoothing = .linear
//  ) {
//    self.lineWidth = lineWidth
//    //    self.strokeStyle = strokeStyle
//    //    self.smoothing = smoothing
//  }
//}

//extension StrokeStyle: @retroactive Hashable {
//  public func hash(into hasher: inout Hasher) {
//    <#code#>
//  }
//}
