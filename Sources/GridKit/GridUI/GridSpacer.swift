//
//  GridSpacer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/10/2025.
//

import SwiftUI

public struct GridSpacer: View {
  
  let axis: Axis
  let count: Int
  public init(
    _ count: Int,
    axis: Axis = .horizontal
  ) {
    self.count = count
    self.axis = axis
  }
  public var body: some View {
    
    Spacer()
      .frameFromGridLength(
        axis: axis,
        length: count,
      )
  }
}
