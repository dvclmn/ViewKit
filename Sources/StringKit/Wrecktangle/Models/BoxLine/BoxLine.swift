//
//  Line.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

/// Currently this library can only handle horizontal dividers, not vertical.
/// So processing line-by-line, vertically, is fairly straightforward.
extension Box {

  public struct BoxLine {
    let content: LineContent

    /// The width left for content, after leading/trailing
    /// structure/padding/shadow is accounted for
    let remainingWidth: Int
    let leadingCap: Box.Part
    let trailingCap: Box.Part
    let theme: Box.Theme

    /// Default initialiser (structure-based)
    init(
      remainingWidth: Int,
      repeater: Box.Part,
      leadingCap: Box.Part,
      trailingCap: Box.Part,
      theme: Box.Theme
    ) {
      self.remainingWidth = remainingWidth

      self.content = StructuralContent(adjustedWidth: remainingWidth, repeatingPattern: repeater)
      self.leadingCap = leadingCap
      self.trailingCap = trailingCap
      self.theme = theme
    }

    /// Convenience initialiser for text-based content
    init(
      text: String,
      lineLimit: Int,
      remainingWidth: Int,
      theme: Box.Theme
    ) {

      self.content = TextContent(text, lineLimit: lineLimit)
      self.remainingWidth = remainingWidth
      self.theme = theme

      /// Currently, this initialiser 'has to' take in a `theme` parameter, to obtain
      /// the correct `Box.Parts` for the leading and trailing caps, to save
      /// the package user from having to do it. Text-based lines will always
      /// have the below part types (obviously with the correct glyphs subbed
      /// in based on the selected Theme).
      self.leadingCap = Box.Part.create(.vertical(.leading), with: theme)
      self.trailingCap = Box.Part.create(.vertical(.trailing), with: theme)

      let conditions = Self.checkConditions(leadingCap: self.leadingCap, trailingCap: self.trailingCap)

      precondition(
        conditions.condition,
        conditions.message
      )

    }
  }
}

extension Box.BoxLine {

  public protocol LineContent {
    var rawContent: String { get }
  }

  public typealias ThreePartLine = (
    leading: Box.PartType,
    repeater: Box.PartType,
    trailing: Box.PartType
  )

  /// What kinds of lines could there be, in a box?
  ///
  /// Note: These, by definition, describe a *whole* line, stretching
  /// from one end to the other. Not just a sub-component.
  ///
  /// E.g. `top` would consist of a leading cap, repeating part, and trailing cap.
  public enum LineType: Hashable, Sendable {
    case top
    case divider
    case bottom
    case text(content: String, lineLimit: Int = 0)

    public var parts: ThreePartLine? {
      switch self {
        case .top:
          (
            Box.PartType.corner(.topLeading),
            Box.PartType.horizontal(.top),
            Box.PartType.corner(.topTrailing)
          )
        case .divider:
          (
            Box.PartType.join(.leading),
            Box.PartType.horizontal(.interior),
            Box.PartType.join(.trailing)
          )
        case .bottom:
          (
            Box.PartType.corner(.bottomLeading),
            Box.PartType.horizontal(.bottom),
            Box.PartType.corner(.bottomTrailing)
          )
        case .text:
          nil
      }
    }  // END parts

    private static let shadowLookup: [LineType: Set<Box.LightSource>] = [
      .top: [.bottomLeading, .bottomTrailing],
      .bottom: [.topLeading, .topTrailing],
    ]

    func hasShadow(lightSource: Box.LightSource) -> Bool {
      switch self {
        case .top, .bottom:
          return Self.shadowLookup[self, default: []].contains(lightSource)
        case .divider, .text:
          return false
      }
    }
  }

}
