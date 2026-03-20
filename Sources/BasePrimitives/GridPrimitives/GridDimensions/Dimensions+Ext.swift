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
    let height: Int = lines(omissionStrategy: .doNotOmit).count
    return GridDimensions(width: width, height: height)
  }
}
