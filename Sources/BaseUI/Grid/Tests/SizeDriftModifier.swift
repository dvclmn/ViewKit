//
//  SizeDriftModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import LayoutKit
import StringShared
import SwiftUI

public struct SizeDriftView: View {

  let fontSize: CGFloat
  public var body: some View {

    VPack {
      SizeDriftInternal(width: 38)
    }
    .gridGuide(opacity: 0.1)
    .setCharacterUnitSize()
    .gridFont(.sfMono, size: fontSize)

  }
}
#if DEBUG
#Preview(traits: .size(.wide)) {
  SizeDriftView(fontSize: 28)
    .padding()
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: .leading
    )
}
#endif
