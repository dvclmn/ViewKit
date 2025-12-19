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

struct PlatformFontsView: View {

  //  @State private var fonts: [FontComparison] = [
  //    FontComparison(.title, .title1),
  //    FontComparison(.title2, .title2),
  //    FontComparison(.title3, .title3),
  //  ]

  //  @State private var fonts: [Font.TextStyle: NSFont.TextStyle] = [
  //    .title: .title1,
  //    .title2: .title2,
  //    .title3: .title3,
  //  ]

  var body: some View {

    List {
      ForEach(Font.TextStyle.allCases, id: \.self) { style in
        //    ForEach(fonts, id: \.self) { style in

        VStack(alignment: .leading) {
          Text(exampleText("SwiftUI", for: String(describing: style)))
            .font(Font.system(style))

          Text(exampleText("AppKit", for: getStyleText(from: style.nsTextStyle)))
            .font(
              Font(NSFont.preferredFont(forTextStyle: style.nsTextStyle))
            )

//          Text(exampleText("AppKit", for: getStyleText(from: style.nsTextStyle)))
//            .font(
//              Font(NSFont.preferredFont(style))
//            )
        }
        .padding(.bottom)

        .textSelection(.enabled)
        //      Text("Hello")
      }
    }

    //    ForEach(fonts, id: \.0) { value in
    //    }

    //    ForEach(fonts.sorted(by: {
    //      $0.key < $1.key
    //    }), id: \.key) { key, value in
    //      Text("Example text for \(key) → \(value)")
    //    }
    //    TextEditor(text: $document.table.text)
  }
}

extension PlatformFontsView {

  private func exampleText(_ framework: String, for styleString: String) -> LocalizedStringKey {
    //  private func exampleText(for style: Font.TextStyle) -> String {
    "Example text for comparison. This is **\(framework)'s** `\(styleString)`".toMarkdownCompatible
  }

  private func fontString(_ style: Font.TextStyle) -> String {
    String(describing: style)
  }

  private func getStyleText(from style: NSFont.TextStyle) -> String {
    // NSFontTextStyle(_rawValue: UICTFontTextStyleTitle1)
    let text = style.rawValue
    let thing = text.split(
      separator: "TextStyle", maxSplits: 1, omittingEmptySubsequences: true)
    let result = String(thing.last ?? "")
    return result

  }
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
