//
//  BFP+Zoom.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/1/2026.
//

import Foundation

extension BinaryFloatingPoint {

  /// Only for if `self` is in normalised [0,1] space
//  public func removingZoomNormalised(_ zoom: Self) -> Self {
//    guard zoom >= 0 else { return self }
//    return self / (1 + zoom)
//  }

  /// Only for if `self` is a percent (0–100):
  public func removingZoomPercent(_ percent: Self) -> Self {
    let normalised = percent / 100
    return self / (1 + normalised)
  }

  //  public func removingZoomPercent(_ zoomPercent: Self) -> Self {
  //    let result = Double(self) / pow(1 + Double(zoomPercent), 1)
  //    return Self(result)
  //  }

}
