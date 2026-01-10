//
//  PlatformFontsComparison.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI


struct PlatformFontsView: View {
  var body: some View {

    List {
      ForEach(Font.TextStyle.allCases, id: \.self) { style in

        VStack(alignment: .leading, spacing: 3) {
          ForEach(PlatformType.allCases, id: \.self) { platform in
            TextContent(style: style, platform: platform)
          }
        }
        .padding(.top, 2)
        .padding(.bottom, 8)
        .textSelection(.enabled)
      }
    }
    .alternatingRowBackgrounds()

  }
}


extension PlatformFontsView {

  private var exampleText: String {
    "Example text for comparison. The quick brown fox jumps over the lazy dog."
  }

  @ViewBuilder
  private func TextContent(style: Font.TextStyle, platform: PlatformType) -> some View {
    HStack {

      VStack(alignment: .leading) {
        //      HStack {
        Text(platform.name)
        //        Text("—")
        Text(platform.styleName(for: style))
          .foregroundStyle(.secondary)
          .monospaced()
      }
      .foregroundStyle(.tertiary)
      .font(.caption2.weight(.semibold))
      .frame(width: 80, alignment: .leading)

      Text(exampleText)
        .lineLimit(1)
        .font(platform.font(for: style))
    }
  }
}


#Preview {
  PlatformFontsView()
    .padding(4)
    .frame(
      width: 780,
      height: 750,
      alignment: .topLeading
    )
}
