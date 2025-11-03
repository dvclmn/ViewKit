//
//  Line.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation

/// ``Box``
/// ``Box/Line``
///
/// I am opting to keep this flatter nesting (e.g. not nesting
/// `PartType` further, within `Part`. Otherwise
/// nesting will become too deep and unweildy.
/// ``Box/Part``
/// ``Box/PartType``
///
///
/// ``Box/Theme``
/// ``Box/Config``

extension Box {
  public struct Line {
    public let leading: Box.PartType
    public let body: Box.PartType
    public let trailing: Box.PartType

    public init(
      leading: Box.PartType,
      body: Box.PartType,
      trailing: Box.PartType
    ) {
      // Basic invariant: if body is text (single row), caps must be 1 high.
      //      precondition(
      //        !(body.type.isText && (leading.height > 1 || trailing.height > 1)),
      //        """
      //        Text lines must have single-character caps.
      //        Leading: \(leading.height), Trailing: \(trailing.height)
      //        """
      //      )
      self.leading = leading
      self.body = body
      self.trailing = trailing
    }
  }
}
extension Box.Line {

  public static func joined(
    lines: [Box.Line],
    with theme: Box.Theme
  ) -> StringStack {
    let stack: StringStack = lines.reduce(into: "") { partial, line in
      //    return lines.reduce(into: StringStack("")) { partial, line in
      partial += line.output(with: theme)
    }
    return stack
  }
  
  public static func joined(
    lines: Box.Line...,
    with theme: Box.Theme
  ) -> StringStack {
    Self.joined(lines: lines, with: theme)
  }

  public func output(with theme: Box.Theme) -> StringStack {

    let stackLeading = leading.buildStack(using: theme)
    let stackBody = leading.buildStack(using: theme)
    let stackTrailing = leading.buildStack(using: theme)

    return StringStack.joined(stackLeading, stackBody, stackTrailing, along: .vertical)
  }

//  public static func joinLines(
//    lines: Box.Line...,
//    with theme: Box.Theme
//  ) -> StringStack {
//
//    return StringStack.joined(<#T##StringStack...#>, along: <#T##Axis#>, padding: <#T##Character?#>)
//    //    return lines.reduce(into: StringStack("")) { partial, line in
//    //      partial += line.output(with: theme)
//    //    }
//  }

  //  public var width: Int { leading.width + body.width + trailing.width }
  //  public var height: Int { max(leading.height, body.height, trailing.height) }
}

//extension Box {
//  public struct Line {
//    public let leading: Part
//    public let body: Part
//    public let trailing: Part
//
//    public init(leading: Part, body: Part, trailing: Part) {
//      /// Basic invariant: leading/trailing must be 1 row high if body is text.
//      precondition(
//        (leading.height == 1 && trailing.height == 1) || !body.type.isText,
//        "Text lines must have single-character caps."
//      )
//      self.leading = leading
//      self.body = body
//      self.trailing = trailing
//    }
//  }
//}

/// Currently this library can only handle horizontal dividers, not vertical.
/// So processing line-by-line, vertically, is fairly straightforward.
//extension Box {
//
//  public struct Line {
//    var leading: Part
//    var body: Part
//    var trailing: Part
//  }
//}
//
//extension Box.Line {
//  static func textLine(_ text: String, theme: Box.Theme) -> Box.Line {
//    Box.Line(
//      leading: .vertical(.leading).build(using: theme),
//      body: .text(text).build(using: theme),
//      trailing: .vertical(.trailing).build(using: theme)
//    )
//  }
//}

//  public struct Line {
//    let content: LineContent
//
//    /// The width left for content, after leading/trailing
//    /// structure/padding/shadow is accounted for
//    let remainingWidth: Int
//    let leadingCap: Box.Part
//    let trailingCap: Box.Part
//    let theme: Box.Theme
//
//    /// Default initialiser (structure-based)
//    init(
//      remainingWidth: Int,
//      repeater: Box.Part,
//      leadingCap: Box.Part,
//      trailingCap: Box.Part,
//      theme: Box.Theme
//    ) {
//      self.remainingWidth = remainingWidth
//
//      self.content = StructuralContent(adjustedWidth: remainingWidth, repeatingPattern: repeater)
//      self.leadingCap = leadingCap
//      self.trailingCap = trailingCap
//      self.theme = theme
//    }
//
//    /// Convenience initialiser for text-based content
//    init(
//      text: String,
//      lineLimit: Int,
//      remainingWidth: Int,
//      theme: Box.Theme
//    ) {
//      self.content = TextContent(text, lineLimit: lineLimit)
//      self.remainingWidth = remainingWidth
//      self.theme = theme
//
//      /// Currently, this initialiser 'has to' take in a `theme` parameter, to obtain
//      /// the correct `Box.Parts` for the leading and trailing caps, to save
//      /// the package user from having to do it. Text-based lines will always
//      /// have the below part types (obviously with the correct glyphs subbed
//      /// in based on the selected Theme).
//      self.leadingCap = Box.Part.create(.vertical(.leading), with: theme)
//      self.trailingCap = Box.Part.create(.vertical(.trailing), with: theme)
//
//      let conditions = Self.checkConditions(
//        leadingCap: self.leadingCap,
//        trailingCap: self.trailingCap
//      )
//
//      precondition(
//        conditions.condition,
//        conditions.message
//      )
//    }
//  }
//}
//
//public protocol LineContent {
//  var rawContent: String { get }
//}
