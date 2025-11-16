//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import CoreTools
import LayoutKit
import SwiftUI

public struct BoxView: View {
  @Environment(\.glyphSet) private var glyphSet
  @Environment(\.frameStyle) private var frameStyle
  @Environment(\.metrics) private var metrics
  @Environment(\.gridWidth) private var gridWidth
  @Environment(\.gridHeight) private var gridHeight
  @Environment(\.explicitFontSize) private var explicitFontSize

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
//    .fixedSize(horizontal: true, vertical: false)
    .fixedSize()
    .gridSetup(.sfMono, fontSize: explicitFontSize ?? 13)

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
    HStack(alignment: .top, spacing: 8) {
      BoxExampleGroup(.sharp)
      BoxExampleGroup(.rounded)
      BoxExampleGroup(.hollow)
      
    }
    //                .environment(\.metrics, .lineNumbers)
    .environment(\.paragraphNumber, 5)
    .setGridFrame(18, alignment: .leading)
    .environment(\.explicitFontSize, 11)

  }
  .textSelection(.enabled)
  .monospaced()
  .padding()
  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  .background(.black.opacity(0.6))
}
#endif
