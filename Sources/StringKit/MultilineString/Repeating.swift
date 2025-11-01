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

    // Create array of stacks to join
    var stacksToJoin = Array(repeating: self, count: fullRepetitions)

    if remainder > 0 {
      let remainderStack: StringStack
      switch trimMethod {
        case .crop:
          remainderStack = self.cropped(toWidth: remainder)
        case .leaveSpace:
          remainderStack = StringStack(
            self.stack.map { row in
              row.prefix(remainder) + .padded(with: paddingCharacter, count: Swift.max(0, remainder - row.count))
            }
          )
      }
      stacksToJoin.append(remainderStack)
    }

    return stacksToJoin.reduce(StringStack([])) { result, stack in
      result.joinedHorizontally(with: stack, padding: trimMethod == .leaveSpace ? paddingCharacter : nil)
    }
  }

  private func cropped(toWidth width: Int) -> StringStack {
    StringStack(self.stack.map { Array($0.prefix(width)) })
  }
}
