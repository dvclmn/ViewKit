//
//  SizeDriftInternal.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import CoreTools
import LayoutKit
import SwiftUI

@available(macOS 14.0, *)
public struct SizeDriftInternal: View {
  @Environment(\.unitSize) private var unitSize

  @State private var sentenceSize: CGSize?

  let width: Int
  public var body: some View {

    VPack(.leading) {
      SizeVisual(from: .unitSize(unitSize))
      SizeVisual(from: .sentence(sentenceBasedSize))
    }

    VPack(.leading) {
      Text(DummyContent.Strings.loremIpsum.prefix(width))
      Text(counter.widthCounter(style: .digits))
    }
    .fixedSize()
    .viewSize(mode: .debounce(0.2)) { size in
      sentenceSize = size
    }

  }
}

@available(macOS 14.0, *)
extension SizeDriftInternal {
  
  private var counter: WidthCounter {
    WidthCounter(width: width)
  }

  private var sentenceBasedSize: CGSize? {
    return sentenceSize?.adjust(.horizontal) { $0 / CGFloat(self.width) }
  }

  @ViewBuilder
  private func SizeVisual(from source: CharacterSizeSource) -> some View {
    HPack {
      ForEach(0..<width, id: \.self) { i in
        Rectangle()
          .fill(source.colour.tertiary)
          .frame(
            width: source.size?.width,
            /// Not assessing height here, just width
            height: unitSize?.height
          )
      }
    }
    .overlay {
      Text(source.name)
        .font(.caption)
    }

  }
}

#if DEBUG
@available(macOS 14.0, *)
#Preview {
  //#Preview(traits: .size(.normal)) {
  SizeDriftInternal(width: 38)
}
#endif
