//
//  CharacterBasedFrame.swift
//  SumBuddy
//
//  Created by Dave Coleman on 10/10/2025.
//

import StringShared
import SwiftUI

//public struct FrameFromGridSize: ViewModifier {
//  //  @Environment(AppHandler.self) private var store
//  //  @Environment(\.characterSize) private var characterSize
//
//  let axis: Axis
//  let size: GridSize
//
//  public func body(content: Content) -> some View {
//    content
//      .overlay {
//        Text("Need to implement")
//      }
//    //      .frame(
//    //        width: width,
//    //        height: ,
//    //        alignment: .leading
//    //      )
//    //      .overlay {
//    //        if characterSize == nil {
//    //          Circle().fill(.red.tertiary)
//    //        }
//    //      }
//
//  }
//}

public struct FrameFromGridLength: ViewModifier {
  @Environment(\.unitSize) private var unitSize

  let axis: Axis
  let length: Int
  let alignment: Alignment

  public func body(content: Content) -> some View {
    content
      .frame(
        width: dimensions.width,
        height: dimensions.height,
        alignment: alignment
      )

  }
}

extension FrameFromGridLength {

  private var dimensions: FrameDimensions {
    guard let unitSize else { return nil }

    let unitLength = axis.length(fromSize: unitSize)
    guard let length = length.toScreenLength(using: unitLength) else { return nil }

    return FrameDimensions(
      fromLength: length,
      axis: axis.toAxisSet,
      alignment: alignment
    )
  }

}
extension View {
  //  public func frameFromGridSize(
  //    for text: String
  //  ) -> some View {
  //    self.modifier(FrameFromCharacterSize(widthCount: text.count))
  //  }

  public func frameFromGridLength(
    axis: Axis = .horizontal,
    length: Int,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromGridLength(
        axis: axis,
        length: length,
        alignment: alignment
      )
    )
  }
}
