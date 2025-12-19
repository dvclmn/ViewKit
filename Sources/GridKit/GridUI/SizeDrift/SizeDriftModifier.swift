//
//  SizeDriftModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import LayoutKit
import CoreTools
import SwiftUI

@available(macOS 14.0, *)
public struct SizeDriftView: View {

  let fontSize: CGFloat
  public var body: some View {

    VPack {
      SizeDriftInternal(width: 38)
    }
    .gridGuide(opacity: 0.1)
    .setCharacterUnitSize(mode: .debounce(0.2))
    .gridFont(.sfMono, size: fontSize)

  }
}
#if DEBUG
@available(macOS 14.0, *)
#Preview {
//#Preview(traits: .size(.wide)) {
  SizeDriftView(fontSize: 28)
    .padding()
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: .leading
    )
}
#endif
