//
//  BoxHandler.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import SwiftUI

extension Box {

  internal func drawBox() -> AttributedString {

    /// We start off with a fresh, blank attr. string. The 'build process' is based
    /// on concatenation, added section-by-section, starting from the top.
    var output = AttributedString()

    /// Add a width counter, according to user's preference ()
    if config.metrics.contains(.widthCounter) {
      output += TextCore.widthCounter(boxWidth, style: config.counterStyle)
    }

    /// Box roof
    let top = line(.top)
    output.append(top, addsLineBreak: true)

    /// Header
    if let headerText = self.header {

      let headerLines = TextFlow(
        text: headerText,
        shouldHyphenate: config.shouldHyphenate,
        width: widthForText,
        paddingCharacter: paddingCharacter(for: .space)
      )
      .flowed(
        maxLines: config.contentLineLimit,
        paddingH: config.theme.padding
      )

      for headerLine in headerLines {
        let boxLine = line(.text(content: headerLine, lineLimit: config.headerLineLimit))
        output.append(boxLine, addsLineBreak: true)
      }
    }

    /// Divider
    let divider = line(.divider)
    output.append(divider, addsLineBreak: true)

    /// Content
    let contentLines = TextFlow(
      text: content.toString,
      shouldHyphenate: config.shouldHyphenate,
      width: widthForText,
      paddingCharacter: paddingCharacter(for: .space)
    )
    .flowed(
      maxLines: config.contentLineLimit,
      paddingH: config.theme.padding
    )

    for contentLine in contentLines {
      let boxLine = line(.text(content: contentLine, lineLimit: config.contentLineLimit))
      output.append(boxLine, addsLineBreak: true)
    }

    /// This could be made conditional on whether the theme's `GlyphSet`
    /// requires it, but this ensures that if there's an alternating frame part,
    /// the number of lines won't create alignment/joining issues
    ///
    //    if !lineCount.isEven {
    //      output += self.constructBoxLine(" ", lineType: .content)
    //    }

    /// Bottom
    let bottom = line(.bottom)
    output.append(bottom, addsLineBreak: true)

    return output
  }

}
