//
//  BoxHandler.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import SwiftUI

extension Box {

  func drawBox() -> AttributedString {

    let builder = Box.Builder(width: boxWidth, theme: theme)

    /// We start off with a fresh, blank attr. string. The 'build process' is based
    /// on concatenation, added section-by-section, starting from the top.
    var output = AttributedString()

    /// Add a width counter, according to user's preference
    if config.metrics.contains(.widthCounter) {
      output.append(TextCore.widthCounter(boxWidth, style: config.counterStyle))
    }

    /// Box roof
    let top = builder.buildLine(.top)
    output.append(top, addsLineBreak: true)

    /// Header
    if let headerText = self.header {
      buildHeader(headerText, builder, output: &output)
    }

    /// Content
    buildContent(builder, output: &output)
    
    /// Bottom
    let bottom = builder.buildLine(.bottom)
    output.append(bottom, addsLineBreak: true)

    return output
  }

  // MARK: - Supporting methods
  private func buildHeader(
    _ text: String,
    _ builder: Box.Builder,
    output: inout AttributedString
  ) {

    let headerLines = TextFlow(
      text: text,
      shouldHyphenate: config.shouldHyphenate,
      width: builder.widthForText,
      paddingCharacter: paddingCharacter(for: .space)
    )
    .flowed(
      maxLines: config.contentLineLimit,
      paddingH: config.theme.padding
    )

    for headerLine in headerLines {
      let boxLine = builder.buildLine(.text(content: headerLine, lineLimit: config.headerLineLimit))
      output.append(boxLine, addsLineBreak: true)
    }

    /// Divider
    let divider = builder.buildLine(.divider)
    output.append(divider, addsLineBreak: true)

  }

  private func buildContent(
    _ builder: Box.Builder,
    output: inout AttributedString
  ) {
    let contentLines = TextFlow(
      text: content.toString,
      shouldHyphenate: config.shouldHyphenate,
      width: builder.widthForText,
      paddingCharacter: paddingCharacter(for: .space)
    )
    .flowed(
      maxLines: config.contentLineLimit,
      paddingH: config.theme.padding
    )

    for contentLine in contentLines {
      let boxLine = builder.buildLine(.text(content: contentLine, lineLimit: config.contentLineLimit))
      output.append(boxLine, addsLineBreak: true)
    }

    /// This could be made conditional on whether the theme's `GlyphSet`
    /// requires it, but this ensures that if there's an alternating frame part,
    /// the number of lines won't create alignment/joining issues
    ///
    //    if !lineCount.isEven {
    //      output += self.constructBoxLine(" ", lineType: .content)
    //    }

  }

}
