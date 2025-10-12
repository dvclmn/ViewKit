//
//  Model+DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import SwiftUI

public struct DisplayString {

  private let components: [DisplayBlock]
  //  private let components: [StyledString]

  /// This is the *top-level* seperator, that appears between
  /// each element in the builder (defined on a new line in
  /// the source code). Defaults to and is frequently set to
  /// a new line character `"\n"`
  private let separator: String

  public init(
    _ separator: String = "\n",
    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  ) {
    self.separator = separator
    self.components = content()
  }
}

extension DisplayString {

  public var plainText: String {
    components.map(\.toStyledString.plainString).joined("  \n")
    //    components.map(\.toStyledString.plainString).joined(separator)
  }

  public var output: AttributedString {
    //    self.output()
    components.map(\.toStyledString.styledString).joined(separator)
  }

  public func markdown(language: String? = nil) -> AttributedString {

    //    let string = components.map { element in
    //      element.toStyledString.plainString
    //    }.joinedLines()

    var markdown = try? AttributedString(
      markdown: plainText,
      options: .init(
        allowsExtendedAttributes: false,
        interpretedSyntax: .full,
        failurePolicy: .throwError,
        languageCode: language,
        appliesSourcePositionAttributes: false
      ),
      baseURL: nil
    )

    //    markdown?.transformingAttributes(\.presentationIntent) { attr in
    //      attr.value = Prese
    //    }
    return markdown ?? output
  }
}

extension DisplayString: StyledStringConvertible {
  public var toStyledString: StyledString {
    StyledString(self.output)
  }

}

extension AttributedString {
  public func monospaced(_ font: Font? = nil) -> AttributedString {
    self.transformingAttributes(\.font) { attr in
      attr.value = font?.monospaced() ?? Font.body.monospaced()
      //      attr.value = Font.body.monospaced()
    }
    //    self.transformingAttributes(
    //      AttributeScopes.SwiftUIAttributes.FontAttribute.Type) { key in
    //        key.
    //      }
  }

}
