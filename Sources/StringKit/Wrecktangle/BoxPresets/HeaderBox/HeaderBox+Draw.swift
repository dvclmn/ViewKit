//
//  Header+Draw.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import Foundation

extension HeaderBox {
  
  func drawBox() -> AttributedString {
    
//    let theme = config.theme
    
//    let top = Box.Line.
    
//    let top = Box.Line.structureLine(.horizontal(.top), theme: theme, width: config.width)
    let header = Box.Line.textLine(box.header ?? "", theme: theme, totalWidth: config.width)
    let separator = Box.Line.structureLine(.horizontal(.middle), theme: theme, width: config.width)
    let content = Box.Line.textLine(box.content.characters, theme: theme, totalWidth: config.width)
    let bottom = Box.Line.structureLine(.horizontal(.bottom), theme: theme, width: config.width)
    
    return StringStack.joinVertically([
      top.render(toTotalWidth: config.width),
      header.render(toTotalWidth: config.width),
      separator.render(toTotalWidth: config.width),
      content.render(toTotalWidth: config.width),
      bottom.render(toTotalWidth: config.width),
    ])
  }
}

    //
    //    let builder = Box.Builder(
    //      width: boxWidth,
    //      height: nil,
    //      config: config
    //    )
    //
    //    /// We start off with a fresh, blank attr. string. The 'build process' is based
    //    /// on concatenation, added section-by-section, starting from the top.
    //    var output = AttributedString()
    //
    //    /// Add a width counter, according to user's preference
    //    if config.metrics.contains(.widthCounter) {
    //      output.append(TextCore.widthCounter(boxWidth, style: config.counterStyle))
    //    }
    //
    //    /// Box roof
    //    let top = builder.buildLine(.structure(.top))
    //    output.append(top, addsLineBreak: true)
    //
    //    /// Header
    //    if let headerText = self.header {
    //      buildHeader(headerText, builder, output: &output)
    //    }
    //
    //    /// Content
    //    buildContent(builder, output: &output)
    //
    //    /// Bottom
    //    let bottom = builder.buildLine(.structure(.bottom))
    //    output.append(bottom, addsLineBreak: true)
    //
    //    return output
//  }

  // MARK: - Supporting methods
  //  private func buildHeader(
  //    _ text: String,
  //    _ builder: Box.Builder,
  //    output: inout AttributedString
  //  ) {
  //
  //    let headerLines = TextFlow(
  //      text: text,
  //      shouldHyphenate: config.shouldHyphenate,
  //      width: builder.widthForText,
  //      paddingCharacter: paddingCharacter(for: .space)
  //    )
  //      .flowed(
  //        maxLines: config.contentLineLimit,
  //        paddingH: config.theme.padding.width
  //      )
  //
  //    for headerLine in headerLines {
  //      let boxLine = builder.buildLine(.text(content: headerLine, lineLimit: config.headerLineLimit))
  //      output.append(boxLine, addsLineBreak: true)
  //    }
  //
  //    /// Divider
  //    let divider = builder.buildLine(.structure(.divider))
  //    output.append(divider, addsLineBreak: true)
  //  }
  //
  //  private func buildContent(
  //    _ builder: Box.Builder,
  //    output: inout AttributedString
  //  ) {
  //    let contentLines = TextFlow(
  //      text: content.toString,
  //      shouldHyphenate: config.shouldHyphenate,
  //      width: builder.widthForText,
  //      paddingCharacter: paddingCharacter(for: .space)
  //    )
  //      .flowed(
  //        maxLines: config.contentLineLimit,
  //        paddingH: config.theme.padding.width
  //      )
  //
  //    for contentLine in contentLines {
  //      let boxLine = builder.buildLine(
  //        .text(
  //          content: contentLine,
  //          lineLimit: config.contentLineLimit
  //        )
  //      )
  //      output.append(boxLine, addsLineBreak: true)
  //    }
  //
  //    /// This could be made conditional on whether the theme's `GlyphSet`
  //    /// requires it, but this ensures that if there's an alternating frame part,
  //    /// the number of lines won't create alignment/joining issues
  //    ///
  //    //    if !lineCount.isEven {
  //    //      output += self.constructBoxLine(" ", lineType: .content)
  //    //    }
  //
  //  }

//}
