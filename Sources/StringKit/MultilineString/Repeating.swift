//
//  Repeating.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

extension StringStack {
  /// See ``StringKit/*(lhs:rhs:)`` for `*` operator used here
  func repeated(_ times: Int) -> StringStack {
    self * times
  }
  
  public func padded(
    to width: Int,
    with character: Character
  ) -> StringStack {
    var result = StringStack([])
    for row in 0..<self.height {
      result.append(self.row(at: row, paddedTo: width, with: character))
    }
    return result
  }

  public func repeatHorizontally(
    to targetWidth: Int,
    paddingCharacter: Character = " ",
    trimMethod: TrimMethod
  ) -> StringStack {

    guard !self.isEmpty, targetWidth > 0 else { return StringStack([]) }

    let patternWidth = self.width
//    let patternHeight = self.height

    /// Early return if no repetition needed
    guard patternWidth < targetWidth else {
      switch trimMethod {
        case .crop:
          return self.cropped(toWidth: targetWidth)
          
        case .leaveSpace:
          return self.padded(to: targetWidth, with: paddingCharacter)
      }
    }

    let fullRepetitions = targetWidth / patternWidth
    let remainder = targetWidth % patternWidth

    /// Create array of stacks to join
    var stacksToJoin = Array(repeating: self, count: fullRepetitions)

    if remainder > 0 {
      let remainderStack: StringStack
      switch trimMethod {
        case .crop:
          remainderStack = self.cropped(toWidth: remainder)
          
        case .leaveSpace:
          remainderStack = StringStack(
            self.stack.map { row in
              row.prefix(remainder) + .padded(
                with: paddingCharacter,
                count: Swift.max(0, remainder - row.count)
              )
            }
          )
      }
      stacksToJoin.append(remainderStack)
    } // END remainder check

//    let result = stacksToJoin.reduce(StringStack([])) { partial, stack in
//      StringStack.joined(partial, stack, along: .horizontal, padding: trimMethod.isLeaveSpace ? paddingCharacter : nil)
//    }

    return Self.joined(
      stacksToJoin,
      along: .horizontal,
      padding: trimMethod.isLeaveSpace ? paddingCharacter : nil
    )

    //    return stacksToJoin.reduce(StringStack([])) { result, stack in
    //      result.joinedHorizontally(with: stack, padding: trimMethod.isLeaveSpace ? paddingCharacter : nil)
    //    }
  }

  private func cropped(toWidth width: Int) -> StringStack {
    StringStack(self.stack.map { Array($0.prefix(width)) })
  }
}

// MARK: - Repeating operator
/// For repeating a `StringStack`
public func * (lhs: StringStack, rhs: Int) -> StringStack {
  var result = StringStack([])
  for _ in 0..<rhs {
    result = result + lhs
  }
  return result
}
