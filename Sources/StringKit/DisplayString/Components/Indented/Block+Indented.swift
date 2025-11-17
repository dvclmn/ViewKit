//
//  Block+Indented.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/11/2025.
//

extension DisplayBlock {

  func createIndented(for indented: Indented) -> StyledString {
    /// Convert all content to styled strings first
    let convertedContent = indented.content.map { $0.toStyledString }
    let indentedElements = indentedElements(content: convertedContent)

    /// Join elements, making sure to indent between
    guard !indentedElements.isEmpty else {
      return StyledString("$", with: .highlighter)
    }

    let result = indentedElements.reduce(into: StyledString("")) { partial, item in
      partial += StyledString("\n") + item
    }

    /// Add title if present
    if let title = indented.title {
      return StyledString(title) + result
    }

    return result
  }

  func indentedElements(
    content: [StyledString],
    indent: String = "  ",
    isLastElement: Bool = false
  ) -> [StyledString] {

    var result: [StyledString] = []

    for (index, element) in content.enumerated() {
//      let isOnlyElement = content.count == 1 && index == 0
      let isLast = index == content.count - 1
      let lines = element.splitByNewlines()

      /// Choose the appropriate prefix character
      let prefixChar: String
      if index == 0 {
        prefixChar = isLastElement ? "└" : "├"
      } else {
        prefixChar = isLast ? "└" : "├"
      }

      /// Process each line
      for (lineIndex, line) in lines.enumerated() {
        if lineIndex == 0 {
          /// First line of element
          let prefix = StyledString(prefixChar + " ", with: .blackOnGreen)
          result.append(prefix + line)
        } else {
          /// Subsequent lines - use vertical line or space for continuation
          let continuationChar = isLast ? " " : "│"
          let prefix = StyledString(continuationChar + indent, with: .blackOnGreen)
          result.append(prefix + line)
        }
      }
    }

    return result
  }

  //  func indentedElements(
  ////    _ indent: String,
  //    content: [StyledString]
  //  ) -> [StyledString] {
  //
  //        let indentTop = "│"
  //    let indentMid = "├"
  //    let indentBottom = "└"
  //
  //
  //    /// Indent each element, handling multi-line content
  //    let indented = content.flatMap { element -> [StyledString] in
  //      let lines = element.splitByNewlines()
  //
  //      /// Handle the edge case of an empty element gracefully.
  ////      guard let firstLine = lines.first else { return [StyledString("")] }
  //
  //      /// Take the rest of the lines...
  ////      let subsequentLines = lines.dropFirst()
  //
  ////      let indentedFirstLine = StyledString(indent, with: .blackOnGreen)
  //
  //      /// ...and map over them to add the indent.
  //      let indentedLines = lines.map { line in
  //
  ////      let indentedSubsequentLines = subsequentLines.map { line in
  //        StyledString(indent, with: .blackOnGreen) + line
  //      }
  //
  //      /// Recombine the first line with the now-indented subsequent lines.
  //      return [firstLine] + indentedSubsequentLines
  //    }
  //    return indented
  //  }
}
