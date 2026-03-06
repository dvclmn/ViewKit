//
//  Path+Smooth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

//import CoreTools
import SwiftUI

extension Array where Element == CGPoint {

  public func createPath(
    type: PathStyle = .line,
    shouldDropFirst: Bool = true
  ) -> Path {
    var builder = WavePathGenerator(points: self)
    return builder.path(withStyle: type)
  }
}
