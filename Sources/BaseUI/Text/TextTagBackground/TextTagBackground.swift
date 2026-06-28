//
//  TextTagBackground.swift
//  ViewKit
//
//  Created by Dave Coleman on 21/2/2026.
//

import SwiftUI

struct RoundedBackgroundAttribute: TextAttribute {}

struct TagEffect: TextRenderer {

  let backgroundColor: Color

  func draw(layout: Text.Layout, in context: inout GraphicsContext) {

    for run in layout.flattenedRuns {
      if run[RoundedBackgroundAttribute.self] != nil {
        let textRect = run.typographicBounds.rect
        let paddingH: CGFloat = 6
        let rect = CGRect(
          origin: textRect.origin.shiftedLeft(by: paddingH / 2),
          size: textRect.size.adjust(.horizontal) { $0 + paddingH }
        )
        let copy = context

        /// Draw the tag's background
        let shape = RoundedRectangle(cornerRadius: 4).path(in: rect)
        copy.fill(shape, with: .color(backgroundColor))
      }
      context.draw(run)
    }
  }
}

struct TagExampleView: View {
  let tagCount: Int
  let tag: LocalizedStringResource
  let title: LocalizedStringResource
  let fontSize: CGFloat
  let tagBackgroundColor: Color
  let tagFontColor: Color
  var body: some View {

    //    let tagPlaceholderText = Text("\(tag)")
    //      .monospaced()
    //      .font(.system(size: fontSize, weight: .heavy))
    //      .foregroundStyle(tagFontColor)
    //      .customAttribute(RoundedBackgroundAttribute())

    Text("This is some ==highlighted== markdown text, with **bold** and *italics*.")
      //    Text("\(tagPlaceholderText) \(title)")
      .font(.system(size: fontSize))
      .textRendererCompatible(
        TagEffect(
          backgroundColor: tagBackgroundColor
        )
      )

  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  TagExampleView(
    tagCount: 6,
    tag: .init("JOIN"),
    title: .init("Get weekly handpicked updates on Swift and SwiftUI!"),
    fontSize: 16,
    tagBackgroundColor: .red,
    tagFontColor: .white
  )
  .frame(width: 160)
}
#endif
