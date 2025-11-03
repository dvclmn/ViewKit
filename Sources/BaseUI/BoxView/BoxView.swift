//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import LayoutKit
import StringShared
import SwiftUI

public struct BoxView: View {
  @Environment(\.glyphSet) private var glyphSet
  @Environment(\.frameStyle) private var frameStyle
  @Environment(\.gridWidth) private var gridWidth
  @Environment(\.gridHeight) private var gridHeight

  @State private var characterSize: CGSize?

  //  let title: String?
  //  let alignment: Alignment
  //  let content: AttributedString
  let content: [any Box.Component]

  public init(
        _ title: String? = nil,
//    separator: String = "\n",
//    alignment: Alignment = .center,
    @BoxBuilder content: () -> [any Box.Component]
      //    @DisplayStringBuilder content: () -> [DisplayBlock]
  ) {
    //    self.title = title
    //    self.alignment = alignment
    self.content = content()
  }

  public var body: some View {
    Text(
      Box(
        width: gridWidth ?? 20,
        height: gridHeight,
        theme: theme
      ) {
        content
      }.plainText
    )
//    .fixedSize(horizontal: true, vertical: false)
    .frameFromGridSize(
      width: gridWidth.map { $0 + theme.padding.width * 2 },
      height: gridHeight
    )
    .gridSetup(.sfMono, fontSize: 15)

//    .environment(\.isShowingGridGuide, true)

    //      .debugTextOverlay(
    //        """
    //        Width: \(gridWidth?.toString, default: "nil")
    //        Text Content: \(content.toString)
    //        """
    //      ).disabled(true)

  }
}

extension BoxView {
  private var theme: Box.Theme {
    Box.Theme(
      glyphSet: glyphSet,
      frameStyle: frameStyle,
      padding: 1
    )
  }

  //  private var textOutput: String {
  //    Box(theme: theme) {
  //
  //      Box.Top()
  //      if let title {
  //        Box.Header(title)
  //        Box.Divider()
  //      }
  //      content.toString
  //      Box.Bottom()
  //
  //    }.plainText
  //  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {

  ScrollView {
    VStack(spacing: 14) {

      //    BoxTextView("I love boxes made of text") {
      //      DummyContent.Strings.paragraphs[8].toAttributed
      //    }
      //    .setGridFrame(42)
//      GroupBox("Top Only") {
//        BoxView {
//          Box.Top()
//        }
//      }
//      
//      GroupBox("Bottom Only") {
//        BoxView {
//          Box.Bottom()
//        }
//      }
      
//      GroupBox("The Lot") {
        BoxView {
          Box.Header("Hello, I'm a Header")
          DummyContent.Strings.paragraphs[0]
          Box.Bottom()
        }
        .setGridFrame(
          30,
//          20,
//          nil,
          alignment: .leading
        )
//      }

    }
  }
  .textSelection(.enabled)
  .monospaced()
  //  .environment(\._lineHeightMultiple, 0.84)
  .frame(
    minWidth: 400,
    minHeight: 600
  )
  .background(.black.opacity(0.6))
}
#endif
