//
//  CharacterWidth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import SharedHelpers
import SwiftUI

public struct CharacterSizeModifier: ViewModifier {

  //  private let character: Character = "M"
  private let guideDimensions = GridDimensions(16, 5)
  let debounceMode: DebounceMode
  let sizeDidChange: (CGSize?) -> Void

  public func body(content: Content) -> some View {
    content
      .overlay {
        Text(guideString)
          .fixedSize()
          .tracking(0)
          .monospaced()
          .allowsTightening(false)
          .viewSize(mode: debounceMode) { size in
            handleSizeChange(size)
            //            sizeDidChange(size)
          }
          .hidden()
          .allowsHitTesting(false)
      }
  }
}

extension CharacterSizeModifier {
  private func handleSizeChange(_ size: CGSize) {
    let width = size.width / CGFloat(guideDimensions.width)
    let height = size.height / CGFloat(guideDimensions.height)
    let result = CGSize(
      width: width.clamped(1),
      height: height.clamped(1)
    )
    sizeDidChange(result)
  }

  private var guideString: String {
    """
    abcdefghijklmnop
    klmnopqrstuvwxyz
    1234567890123456
    ABCDEFGHIJKLMNOP
    KLMNOPQRSTUVWXYZ
    """
  }
}
