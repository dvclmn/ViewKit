//
//  Examples.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import StringKit
import SwiftUI

struct BoxExampleView: View {

  #if os(macOS)
  let boxWidth: Int = 38
  #else
  let boxWidth: Int = 27
  #endif

  var body: some View {

    VStack(spacing: 14) {

      BoxView("I love boxes made of text") {
        Self.testString.toAttributed
      }
      .gridFrame(42)

      BoxView("Header title") {
        "Hello"
      }
      .gridFrame(20)
      .boxStyle(glyphs: .double, frame: .double)

      BoxView {
        "No header text"
        "This is another line"
      }
      .gridFrame(38)
      .boxStyle(glyphs: .rounded, frame: .single)

    }
    .preferredColorScheme(.dark)
    .textSelection(.enabled)
    .monospaced()
    .environment(\._lineHeightMultiple, 0.84)
    .frame(width: 370, height: 640)
    .background(.black.opacity(0.6))
  }
}

#Preview {
  BoxExampleView()
}

extension BoxExampleView {

  //  var box01: Box {
  //    Box(
  //      header: "I love boxes made of text",
  //      content: ,
  //      width: boxWidth,
  //      glyphSet: .rounded,
  //      frameStyle: .double,
  //      counterStyle: .ruler
  //    )
  //  }

  static var testString: String {
    """
    let top = line(.top)
      output.appendString(top, addsLineBreak: true)
      
      /// Header
      if let headerText = self.header {
        
        let headerLines: [String] = headerText.reflowText(
          width: widthForText,
          maxLines: config.headerLineLimit,
          paddingWidth: self.config.theme.padding,
          paddingCharacter: invisibleIfNeeded(.space),
          wrappingOption: self.config.wordWrapStrategy
        )
        
        for headerLine in headerLines {
          let boxLine = line(.text(content: headerLine, lineLimit: config.headerLineLimit))
          output.appendString(boxLine, addsLineBreak: true)
        }
      }


      ╭──────────────────────────────╮
    //│ ╭──────────────────────────╮ │
    //│ │ At this point I've made  │ │
    //│ │ more commits to my repo  │ │
    //│ │ *renaming* it, than I    │ │
    //│ │ have for actual code.    │ │
    //│ │                          │ │
    //│ ╰──────────────────────────╯ │
    //╰──────────────────────────────╯
    /////////////////////////////////



    At this point I've made 
    more commits to my repo 
    renaming it than I have 
    for actual code. 
      
    """
  }
}
