//
//  Repeating.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

extension StringStack {

  public func repeatHorizontally(
    toWidth width: Int,
    paddingCharacter: Character = " ",
    trimMethod: TrimMethod = .crop
  ) -> StringStack {

    guard !self.isEmpty, width > 0 else { return StringStack([]) }

    let patternWidth = self.width
    let patternHeight = self.height

    // Early return if no repetition needed
    guard patternWidth < width else {
      switch trimMethod {
        case .crop:
          return self.cropped(toWidth: width)
        case .leaveSpace:
          // Use your existing padding approach
          var result = StringStack([])
          for row in 0..<patternHeight {
            result.append(self.row(at: row, paddedTo: width, with: paddingCharacter))
          }
          return result
      }
    }

    let fullRepetitions = width / patternWidth
    let remainder = width % patternWidth

    // Build the base repeated pattern (full repetitions only)
    let baseWidth = fullRepetitions * patternWidth
    let basePattern = (0..<fullRepetitions).reduce(StringStack([])) { result, _ in
      result.joinedHorizontally(with: self, padding: nil)
    }

    guard remainder > 0 else { return basePattern }

    // Handle the remainder using your existing joining logic
    switch trimMethod {
      case .crop:
        let remainderStack = StringStack(
          self.stack.map { Array($0.prefix(remainder)) }
        )
        return basePattern.joinedHorizontally(with: remainderStack, padding: nil)

      case .leaveSpace:
        let remainderStack = StringStack(
          self.stack.map { row in
            guard row.count >= remainder else {
              return row + .padded(with: paddingCharacter, count: remainder - row.count)
            }
            return Array(row.prefix(remainder))
          }
        )
        return basePattern.joinedHorizontally(with: remainderStack, padding: paddingCharacter)
    }
  }

  private func cropped(toWidth width: Int) -> StringStack {
    StringStack(self.stack.map { Array($0.prefix(width)) })
  }
}
