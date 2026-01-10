//
//  String+Reflow.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import Foundation

public enum PaddingBookend {
  case none
  case both(width: Int)
}

public struct TextReflow {
  let text: String
  let shouldHyphenate: Bool

  /// Width for text only. Do not include space for padding
  /// or any other elements, this should be handled elsewhere
  let width: Int

  /// Used to fill empty space at the end of lines, so that
  /// each line ends up the same length.
  /// Usually a space character, so it is unseen.
  let paddingCharacter: Character

  public init(
    _ text: String,
    width: Int = 20,
    paddingCharacter: Character = " ",
    shouldHyphenate: Bool = true,
  ) {
    self.text = text
    self.shouldHyphenate = shouldHyphenate
    self.width = width
    self.paddingCharacter = paddingCharacter
  }
}

extension TextReflow {

  public func reflowed(maxLines: Int = 0) -> [String] {

    guard width > 0 else {
      print("Error: Width must be positive")
      return []
    }

    /// Calculate the remaining width for text content,
    /// after spacing reserved for structure

    guard width > 0 else {
      print("Error: Width is too small to accommodate padding & content")
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

      /// This feels brittle, treating words as anything space-speratated
      let words = trimmedParagraph.split(separator: " ", omittingEmptySubsequences: false)
      var currentLine = String(leadingWhitespace)

      for word in words {
        let wordString = String(word)

        if currentLine == String(leadingWhitespace) && (currentLine.count + wordString.count) <= width {
          currentLine += wordString
        } else if currentLine.count + wordString.count + 1 <= width {
          if !currentLine.isEmpty && currentLine != String(leadingWhitespace) {
            currentLine += " "
          }
          currentLine += wordString
        } else {

          reflowedLines.append(
            padLine(currentLine, bookends: .none)
          )

          /// Handle word exceeding width
          if wordString.count > width {
            let wrappedWords = wrapLongWord(
              wordString,
              width: width
            )

            reflowedLines.append(
              contentsOf: wrappedWords.dropLast().map {
                padLine($0, bookends: .none)
              })
            currentLine = wrappedWords.last ?? ""
          } else {
            currentLine = String(leadingWhitespace) + wordString
          }
        }
      }

      if !currentLine.isEmpty {
        reflowedLines.append(
          padLine(currentLine, bookends: .none)
        )
      }
    }

    if maxLines > 0 {
      reflowedLines = Array(reflowedLines.prefix(maxLines))
    }

    return reflowedLines
  }

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

  func padLine(_ line: String, bookends: PaddingBookend = .none) -> String {

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
