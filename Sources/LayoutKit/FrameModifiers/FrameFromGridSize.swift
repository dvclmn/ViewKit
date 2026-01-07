//
//  CharacterBasedFrame.swift
//  SumBuddy
//
//  Created by Dave Coleman on 10/10/2025.
//

import SharedHelpers
import SwiftUI

public struct FrameFromUnitSize: ViewModifier {
  @Environment(\.unitSize) private var unitSize

  let width: Int?
  let height: Int?
  let alignment: Alignment

  public func body(content: Content) -> some View {
    content
      .frame(
        width: width?.toScreenLength(along: .horizontal, using: unitSize),
        height: height?.toScreenLength(along: .vertical, using: unitSize),
        alignment: alignment
      )
  }
}


extension View {

  public func frameFromUnitSize(
    width: Int?,
    height: Int?,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromUnitSize(
        width: width,
        height: height,
        alignment: alignment
      )
    )
  }
}

//extension View {
//  public func frameFromGridDimensions(
//    _ dimensions: GridDimensions,
//    cellSize: CGSize,
//    alignment: Alignment = .center
//  ) -> some View {
//    self.modifier(
//      FrameFromSizeModifier(
//        width: dimensions.width(with: cellSize),
//        height: dimensions.height(with: cellSize),
//        alignment: alignment
//      )
//    )
//  }
//}
