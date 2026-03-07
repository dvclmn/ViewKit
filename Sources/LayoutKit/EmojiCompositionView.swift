//
//  EmojiCompositionView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

//import BasePrimitives
import BasePrimitives
import SwiftUI

public struct EmojiCompositionView: View {
  @Environment(\.isDebugMode) private var isDebugMode
  @Environment(\.controlSize) private var controlSize
  let composition: EmojiComposition

  public init(composition: EmojiComposition) {
    self.composition = composition
  }

  public var body: some View {

    ZStack {
      ForEach(composition.emoji) { comp in
        Text(comp.emoji.toString)
          .offset(comp.offset)
          .rotationEffect(comp.rotation)
          .scaleEffect(comp.scale)
      }
      .font(.system(size: controlSize.scale(fontSize)))

      if isDebugMode {
        Circle()
          .fill(.teal)
          .stroke(.blue, lineWidth: 1)
          .frame(width: 8, height: 8)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    //    .drawingGroup()
  }
}

extension EmojiCompositionView {
  private var fontSize: CGFloat {
    20 * composition.scale
  }
}
#if DEBUG
#Preview {
  EmojiCompositionView(composition: .example)
    .frame(width: 400, height: 600)
    .environment(\.isDebugMode, true)
  // .environment(store)
}
#endif
