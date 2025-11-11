//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import BaseUtilities
import LayoutKit
import SwiftUI

public struct BoxView: View {
  @Environment(\.glyphSet) private var glyphSet
  @Environment(\.frameStyle) private var frameStyle
  @Environment(\.metrics) private var metrics
  @Environment(\.gridWidth) private var gridWidth
  @Environment(\.gridHeight) private var gridHeight

  @State private var characterSize: CGSize?

  let content: [any Box.Component]

  public init(
    @BoxBuilder content: () -> [any Box.Component]
  ) {
    self.content = content()
  }

  public var body: some View {
    Text(
      Box(
        width: gridWidth ?? 15,
        height: gridHeight,
        theme: theme,
        metrics: metrics
      ) {
        content
      }.plainText
    )
    .fixedSize(horizontal: true, vertical: false)

    .gridSetup(.sfMono, fontSize: 13)

    .environment(\.isShowingGridGuide, false)

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
}

extension EnvironmentValues {
  @Entry var paragraphNumber: Int? = nil
}


#if DEBUG
#Preview(traits: .size(.normal)) {

  ScrollView {
    HStack(alignment: .top, spacing: 24) {
      //    VStack(alignment: .leading, spacing: 14) {

      GroupBox("Sharp") {
        BoxViewExample()
          .setBoxStyle(
            glyphs: .sharp,
            frame: .single,
          )
        Divider()
        BoxViewExample()
          .setBoxStyle(
            glyphs: .sharp,
            frame: .double,
          )
      }

      GroupBox("Round") {
        BoxViewExample()
          .setBoxStyle(
            glyphs: .rounded,
            frame: .single,
          )

        Divider()
        BoxViewExample()
          .setBoxStyle(
            glyphs: .rounded,
            frame: .double,
          )
      }
      GroupBox("Hollow") {
        BoxViewExample()
          .setBoxStyle(
            glyphs: .hollow,
            frame: .single,
          )

        Divider()
        BoxViewExample()
          .setBoxStyle(
            glyphs: .hollow,
            frame: .double,
          )
      }

      //
      //      BoxView {
      //        Box.Header("Rounded glyphs, Double Frame")
      //        DummyContent.Strings.paragraphs[6].prefix(120).toString
      //
      //        //        Box.Divider()
      //        //                        "Last text sign-off"
      //        //                  Box.Bottom()
      //        //                          Box.Bottom()
      //        //                  Box.Bottom()
      //      }
      //      //      .environment(\.metrics, .lineNumbers)
      //      .setBoxStyle(
      //        glyphs: .rounded,
      //        frame: .double,
      //      )
    }
    .environment(\.paragraphNumber, 5)
    .setGridFrame(22, alignment: .leading)

  }
  .textSelection(.enabled)
  .monospaced()
  .padding()
  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  .background(.black.opacity(0.6))
}
#endif
