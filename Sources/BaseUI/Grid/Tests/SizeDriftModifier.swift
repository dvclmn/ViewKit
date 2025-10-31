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

  let width: Int
  let fontSize: CGFloat
  public var body: some View {

    VPack(.leading) {
      Text(DummyContent.Strings.loremIpsum.prefix(width))
      Text(TextCore.widthCounter(width, style: .digits))
    }
    .fixedSize()
    
    .gridGuide(opacity: 0.1)
    .setCharacterUnitSize()
    .gridFont(.sfMono, size: fontSize)

  }
}
#if DEBUG
#Preview(traits: .size(.wide)) {
  SizeDriftView(width: 38, fontSize: 28)
    .padding()
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: .leading
    )
}
#endif
