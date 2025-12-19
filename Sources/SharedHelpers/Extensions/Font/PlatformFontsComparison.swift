//
//  PlatformFontsComparison.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//
//import SwiftUI
//
//struct PlatformFontsView: View {
//
//  @State private var fonts: [(Font.TextStyle, NSFont.TextStyle)] = [
//    (.title, .title1),
//    (.title2, .title2),
//    (.title3, .title3),
//  ]
//
//  //  @State private var fonts: [Font.TextStyle: NSFont.TextStyle] = [
//  //    .title: .title1,
//  //    .title2: .title2,
//  //    .title3: .title3,
//  //  ]
//
//  var body: some View {
//
//    ForEach(fonts, id: \.0) { value in
//      Text(
//        "Example text for \(String(describing: value.0)) → \(getStyleText(from: value.1))"
//      )
//      .textSelection(.enabled)
//    }
//
//    //    ForEach(fonts.sorted(by: {
//    //      $0.key < $1.key
//    //    }), id: \.key) { key, value in
//    //      Text("Example text for \(key) → \(value)")
//    //    }
//    //    TextEditor(text: $document.table.text)
//  }
//}
//
//extension PlatformFontsView {
//  private func getStyleText(from style: NSFont.TextStyle) -> String {
//    // NSFontTextStyle(_rawValue: UICTFontTextStyleTitle1)
//    let text = style.rawValue
//    let thing = text.split(
//      separator: "TextStyle", maxSplits: 1, omittingEmptySubsequences: true)
//    let result = String(thing.last ?? "")
//    return result
//
//  }
//}
//
//#Preview {
//  PlatformFontsView()
//}
