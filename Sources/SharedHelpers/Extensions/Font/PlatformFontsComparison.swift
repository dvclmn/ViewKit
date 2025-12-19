//
//  PlatformFontsComparison.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//
import SwiftUI

struct FontComparison: Hashable {
  let swiftUI: Font.TextStyle
  let appKit: NSFont.TextStyle

  init(_ swiftUI: Font.TextStyle, _ appKit: NSFont.TextStyle) {
    self.swiftUI = swiftUI
    self.appKit = appKit
  }
}

enum PlatformType: String, CaseIterable {
  case swiftUI
  case appKit

  var name: String {
    switch self {
      case .swiftUI: "SwiftUI"
      case .appKit: "AppKit"
    }
  }

  func font(for style: Font.TextStyle) -> Font {
    switch self {
      case .swiftUI: Font.system(style)
      case .appKit: Font(NSFont.preferredFont(for: style))
    }
  }

  func styleName(for style: Font.TextStyle) -> String {
    switch self {
      case .swiftUI:
        return String(describing: style)
      case .appKit:
        let text = style.nsTextStyle.rawValue.split(
          separator: "TextStyle",
          maxSplits: 1,
          omittingEmptySubsequences: true
        )
        let result = String(text.last ?? "")
        return result

    }
    //    let font = self.font(for: style)

  }
}

struct PlatformFontsView: View {
  var body: some View {

    List {
      ForEach(Font.TextStyle.allCases, id: \.self) { style in

        VStack(alignment: .leading, spacing: 12) {

          ForEach(PlatformType.allCases, id: \.self) { platform in

            VStack(alignment: .leading) {

              HStack {
                Text(platform.name)
                Text("—")
                Text(platform.styleName(for: style))
                  .foregroundStyle(.secondary)
                  .monospaced()
              }
              .foregroundStyle(.tertiary)
              .font(.callout.weight(.semibold))

              Text(exampleText("SwiftUI", for: String(describing: style)))
                .lineLimit(1)
                .font(platform.font(for: style))
              //              .font(Font.system(style))
            }
          }

          //          Text(exampleText("AppKit", for: getStyleText(from: style.nsTextStyle)))
          //            .font(
          //              Font(NSFont.preferredFont(forTextStyle: style.nsTextStyle))
          //            )

          //          Text(exampleText("AppKit", for: getStyleText(from: style.nsTextStyle)))
          //            .font(
          //              Font(NSFont.preferredFont(style))
          //            )
        }
        .padding(.top, 8)
        .padding(.bottom, 12)

        .textSelection(.enabled)
        //      Text("Hello")
      }
    }

  }
}

extension PlatformFontsView {

  private func exampleText(_ framework: String, for styleString: String) -> String {
    //  private func exampleText(_ framework: String, for styleString: String) -> LocalizedStringKey {
    //  private func exampleText(for style: Font.TextStyle) -> String {
    "Example text for comparison. The quick brown fox jumps over the lazy dog."
    //    "Example text for comparison. This is **\(framework)'s** `\(styleString)`".toMarkdownCompatible
  }

  //  private func fontString(_ style: Font.TextStyle) -> String {
  //    String(describing: style)
  //  }
  //
  //  private func getStyleText(from style: NSFont.TextStyle) -> String {
  //
  //  }
}

#Preview {
  PlatformFontsView()
    .padding(4)
    .frame(
      width: 780,
      height: 700,
      alignment: .topLeading
    )
}
