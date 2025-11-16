//
//  SizeDriftInternal.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import LayoutKit
import CoreTools
import SwiftUI

enum CharacterSizeSource {
  case unitSize(CGSize?)
  case sentence(CGSize?)

  var name: String {
    switch self {
      case .unitSize: "Unit Size"
      case .sentence: "Sentence"
    }
  }

  var size: CGSize? {
    switch self {
      case .unitSize(let size): size
      case .sentence(let size): size
    }
  }

  var colour: Color {
    switch self {
      case .unitSize: Color.green
      case .sentence: Color.blue
    }
  }
}

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
    return sentenceSize?.adjustLength(.horizontal) { $0 / CGFloat(self.width) }
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
#Preview(traits: .size(.normal)) {
  SizeDriftInternal(width: 38)
}
#endif
