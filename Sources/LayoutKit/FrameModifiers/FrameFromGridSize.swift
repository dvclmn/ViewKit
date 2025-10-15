//
//  CharacterBasedFrame.swift
//  SumBuddy
//
//  Created by Dave Coleman on 10/10/2025.
//

import SwiftUI
import ToolKit

public struct FrameFromGridSize: ViewModifier {
  @Environment(AppHandler.self) private var store
  @Environment(\.characterSize) private var characterSize

  let axis: Axis
  let size: GridSize

  public func body(content: Content) -> some View {
    content
      .frame(
        width: width,
        height: ,
        alignment: .leading
      )
      .overlay {
        if characterSize == nil {
          Circle().fill(.red.tertiary)
        }
      }

  }
}
extension FrameFromCharacterSize {

  private var width: FrameDimensions {
//  private var width: CGFloat? {
    
    
//    return widthCount.toScreenLength(along: .horizontal)
//    return widthCount.floategerWidth
    
    
//    let diffResult = store.characterCalculator.width(for: widthCount)
//    return result
    
//    guard let charWidth = characterSize?.width else { return nil }
//    let result = CGFloat(widthCount) * charWidth
//    print("Character-based frame width: \(result, default: "nil")")
//    print("Different result width: \(diffResult, default: "nil")")
//    print("Store vs Env char size:\n\nStore: \(store.characterSize?.displayString, default: "nil")\nEnv:   \(characterSize?.displayString, default: "nil")")
//    return diffResult
  }

}
extension View {
  public func frameFromCharacterSize(
    for text: String
  ) -> some View {
    self.modifier(FrameFromCharacterSize(widthCount: text.count))
  }

  public func frameFromGridLength(
    axis: Axis,
    length: Int
  ) -> some View {
    self.modifier(FrameFromCharacterSize(widthCount: widthCount))
  }
}
