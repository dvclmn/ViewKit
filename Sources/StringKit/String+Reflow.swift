//
//  String+Reflow.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

//public enum WordWrapStrategy: Sendable {
//  case hyphenate
//  case wrap
////  case crop
//}
public enum PaddingBookend {
  case none
  case both(width: Int)
}

public struct TextFlow {
  let text: String
  let shouldHyphenate: Bool
  let width: Int
  let paddingCharacter: Character

  public init(
    text: String,
    shouldHyphenate: Bool = true,
    width: Int = 20,
    paddingCharacter: Character = " "
  ) {
    self.text = text
    self.shouldHyphenate = shouldHyphenate
    self.width = width
    self.paddingCharacter = paddingCharacter
  }
}

extension TextFlow {

  public func flowed(
    maxLines: Int = 0,
    paddingH: Int = 1,  // leading and trailing
  ) -> [String] {

    guard width > 0 else {
      print("Error: Width must be positive")
      return []
    }

    /// Calculate the remaining width for text content,
    /// after spacing reserved for structure
    let effectiveWidth = width - (2 * paddingH)
    guard effectiveWidth > 0 else {
      print("Error: Width is too small to accommodate padding")
      return []
    }

    let paragraphs = text.components(separatedBy: .newlines)
    var reflowedLines: [String] = []

    for paragraph in paragraphs {
      if paragraph.isEmpty {
        reflowedLines.append(String(repeating: paddingCharacter, count: width))
        continue
      }

      /// Preserve leading whitespace
      let leadingWhitespace = paragraph.prefix(while: { $0.isWhitespace })
      let trimmedParagraph = paragraph.dropFirst(leadingWhitespace.count)

      let words = trimmedParagraph.split(separator: " ", omittingEmptySubsequences: false)
      var currentLine = String(leadingWhitespace)

      for word in words {
        let wordString = String(word)

        if currentLine == String(leadingWhitespace) && (currentLine.count + wordString.count) <= effectiveWidth {
          currentLine += wordString
        } else if currentLine.count + wordString.count + 1 <= effectiveWidth {
          if !currentLine.isEmpty && currentLine != String(leadingWhitespace) {
            currentLine += " "
          }
          currentLine += wordString
        } else {

          reflowedLines.append(
            padLine(currentLine, bookends: .both(width: paddingH))
          )

          // Handle word exceeding width
          if wordString.count > effectiveWidth {
            let wrappedWords = wrapLongWord(
              wordString,
              width: effectiveWidth
            )

            reflowedLines.append(
              contentsOf: wrappedWords.dropLast().map {
                padLine($0, bookends: .both(width: paddingH))
              })
            currentLine = wrappedWords.last ?? ""
          } else {
            currentLine = String(leadingWhitespace) + wordString
          }
        }
      }

      if !currentLine.isEmpty {
        reflowedLines.append(
          padLine(currentLine, bookends: .both(width: paddingH))
        )
      }
    }

    if maxLines > 0 {
      reflowedLines = Array(reflowedLines.prefix(maxLines))
    }

    return reflowedLines
  }

}

extension TextFlow {

  private func wrapLongWord(
    _ word: String,
    width: Int,
  ) -> [String] {
    var wrappedWords: [String] = []
    var remainingWord = word

    while !remainingWord.isEmpty {
      if remainingWord.count <= width {
        wrappedWords.append(remainingWord)
        break
      }
      let splitIndex = width - (shouldHyphenate ? 1 : 0)
      let hyphenIfNeeded = shouldHyphenate ? "-" : ""
      let line = remainingWord.prefix(splitIndex) + hyphenIfNeeded
      wrappedWords.append(String(line))
      remainingWord = String(remainingWord.dropFirst(splitIndex))
    }

    return wrappedWords
  }

  func padLine(
    _ line: String,
    //    toFill width: Int,
    //    with character: Character,
    bookends: PaddingBookend = .none
  ) -> String {

    /// Start with current line content
    var result: String = line

    switch bookends {
      case .both(let bookendWidth):
        let bookendPadding = String(repeating: paddingCharacter, count: bookendWidth)
        result = bookendPadding + result + bookendPadding
      case .none:
        break
    }

    let remainingWidth = max(0, width - result.count)
    result += String(repeating: paddingCharacter, count: remainingWidth)

    return result

  }
}
