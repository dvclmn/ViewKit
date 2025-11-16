//
//  BoxViewExample.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

import CoreTools
import SwiftUI

public struct BoxViewExample: View {
  @Environment(\.glyphSet) private var glyphSet
  @Environment(\.frameStyle) private var frameStyle
  @Environment(\.paragraphNumber) private var paragraphNumber

  let textLength: Int
  //  let paragraph: Int?

  init(
    textLength: Int = 100,
    //    paragraph: Int? = nil
  ) {
    self.textLength = textLength
    //    self.paragraph = paragraph
  }
  public var body: some View {

    BoxView {
      Box.Header("Glyphs: \(glyphSet.design.name), Frame: \(frameStyle.name).")
      DummyContent.Strings.paragraphs[paragraphIndex].prefix(textLength).toString
    }
    .padding(6)
    //      .environment(\.metrics, .lineNumbers)
    //      .environment(\.metrics, [])

  }
}

extension BoxViewExample {
  private var paragraphIndex: Int {
    guard let paragraphNumber else {
      let range = 0..<(DummyContent.Strings.paragraphs.count - 1)
      return range.randomElement() ?? 0

    }
    return paragraphNumber

  }
}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  @Previewable @State var store = AppHandler()
//  ExampleView()
//    .environment(store)
//}
//#endif

public struct BoxExampleGroup: View {

  let glyphSet: Box.GlyphSet

  public init(_ glyphSet: Box.GlyphSet) {
    self.glyphSet = glyphSet
  }
  public var body: some View {

    VStack {
      Section(glyphSet.design.name) {
        BoxViewExample()
          .setBoxStyle(
            glyphs: glyphSet,
            frame: .single,
          )
        //          Divider()
        BoxViewExample()
          .setBoxStyle(
            glyphs: glyphSet,
            frame: .double,
          )
      }
    }

  }
}
