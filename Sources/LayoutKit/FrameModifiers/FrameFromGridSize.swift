//
//  CharacterBasedFrame.swift
//  SumBuddy
//
//  Created by Dave Coleman on 10/10/2025.
//

import BasePrimitives
import BaseTools
import SwiftUI

public struct FrameFromUnitSize: ViewModifier {
  @Environment(\.activeUnitSize) private var unitSize

  let width: Int?
  let height: Int?
  let alignment: Alignment

  public func body(content: Content) -> some View {
    content
      .frame(
        width: width?.toScreenLengthIfPossible(along: .horizontal, using: unitSize),
        height: height?.toScreenLengthIfPossible(along: .vertical, using: unitSize),
        alignment: alignment
      )
  }
}

extension View {

  public func frameFromGridDimensions(
    gridDimensions: FrameGridDimensions
  ) -> some View {
    self.modifier(
      FrameFromUnitSize(
        width: gridDimensions.width,
        height: gridDimensions.height,
        alignment: gridDimensions.alignment
      )
    )
  }

  public func frameFromGridDimensions(
    gridDimensions: GridDimensions,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromUnitSize(
        width: gridDimensions.width,
        height: gridDimensions.height,
        alignment: alignment
      )
    )
  }

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
