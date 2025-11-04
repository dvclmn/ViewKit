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

  let content: [any Box.Component]

  public init(
    @BoxBuilder content: () -> [any Box.Component]
  ) {
    self.content = content()
  }

  public var body: some View {
    Text(
      Box(
        width: widthForBoxFrame,
        height: gridHeight,
        theme: theme
      ) {
        content
      }.plainText
    )
    .fixedSize(horizontal: true, vertical: false)
    //    .fixedSize(horizontal: true, vertical: false)
//    .frameFromGridSize(
//      width: widthForBoxFrame,
//      //      width: gridWidth.map { $0 + theme.padding.width * 2 },
//      height: gridHeight
//    )
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

  //  private var widthForBox: Int {
  //    gridWidth ?? 20
  //  }
  //
  private var widthForBoxFrame: Int {

    let proposed = gridWidth ?? 15
//    let frameReserved = theme.frameStyle.reservedDimensions.width
//    let paddingH = theme.padding.width * 2

//    let totalReserved = frameReserved + paddingH
//    return max(0, proposed + totalReserved)
    
    return proposed

  }

  private var theme: Box.Theme {
    Box.Theme(
      glyphSet: glyphSet,
      frameStyle: frameStyle,
      padding: 1
    )
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {

  ScrollView {
    VStack(spacing: 14) {
      BoxView {
        //        Box.Header("Hello, I'm a Header")

        DummyContent.Strings.paragraphs[3]

        //        Box.Divider()
        //        "Last text sign-off"
        //          Box.Bottom()
      }
      .setGridFrame(30, alignment: .leading)
      //      .setBoxStyle(glyphs: .test, frame: .single())
      //      .setBoxStyle(glyphs: .test, frame: .double())
//      .setBoxStyle(glyphs: .rounded, frame: .double())
      .setBoxStyle(glyphs: .rounded, frame: .single(frame: .standard, dividers: .standard))

    }
  }
  .textSelection(.enabled)
  .monospaced()
  .frame(
    minWidth: 400,
    minHeight: 600
  )
  .background(.black.opacity(0.6))
}
#endif
