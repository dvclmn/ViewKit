//
//  SizeDriftInternal.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import LayoutKit
import StringShared
import SwiftUI

public struct SizeDriftInternal: View {
  @Environment(\.unitSize) private var unitSize

  @State private var sentenceSize: CGSize?

  let width: Int
  public var body: some View {

    VPack(.leading) {
      SizeVisual(unitSize)
        .tint(.orange)

      SizeVisual(sentenceBasedSize)
        .tint(.blue)
    }

    VPack(.leading) {
      Text(DummyContent.Strings.loremIpsum.prefix(width))
      Text(TextCore.widthCounter(width, style: .digits))
    }
    .fixedSize()
    .viewSize(mode: .debounce(0.2)) { size in
      sentenceSize = size
    }

  }
}

extension SizeDriftInternal {

  private var sentenceBasedSize: CGSize? {
    return sentenceSize?.adjustLength(.horizontal) { w in
      w / CGFloat(self.width)
      //      let newH = h / CGFloat(1)
      //      return (newW, newH)
    }
  }

  @ViewBuilder
  private func SizeVisual(_ size: CGSize?) -> some View {
    HPack {
      ForEach(0..<width, id: \.self) { i in
        Rectangle()
          .fill(.tint)
          .frame(
            width: size?.width,
            /// Not assessing height here, just width
            height: unitSize?.height
          )
      }
    }

  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  SizeDriftInternal(width: 38)
}
#endif
