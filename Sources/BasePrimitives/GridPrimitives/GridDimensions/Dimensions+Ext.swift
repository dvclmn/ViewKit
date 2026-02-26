//
//  Dimensions+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import SwiftUI

extension String {
  public var gridDimensions: GridDimensions {
    let width: Int = longestLineLength
    let height: Int = substringLines(omissionStrategy: .doNotOmit).count
    return GridDimensions(width: width, height: height)
  }
}

extension CGSize {
  /// This seems silly, not sure when I'll need to create a tiny CGSize
  /// like this, from small integer numbers.
  /// More likely to need functionality like from UnitSize, using a unitsize.
  //  public init(fromGrid dimensions: GridDimensions) {
  //    self.init(
  //      width: CGFloat(dimensions.width),
  //      height: CGFloat(dimensions.height)
  //    )
  //  }
}
