//
//  Box+Line.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

import CoreTools

extension Box {

  /// This is strictly a Three-Part Line. Will need to introduce
  /// a new type/system to support e.g. multi-column Boxes
  public struct Line {
    let leading: LinePart
    let body: LineType
    let trailing: LinePart

    /// Init for Text Line
    public init(
      text: String,
      leading: LinePart,
      trailing: LinePart,
    ) {
      self.leading = leading
      self.body = .text(text)
      self.trailing = trailing
    }

    /// Init for Structure Line
    public init(
      repeating repeater: LinePart,
      leading: LinePart,
      trailing: LinePart,
    ) {
      self.leading = leading
      self.body = .repeater(repeater)
      self.trailing = trailing
    }
  }

  enum LineSegment {
    case leading
    case repeater
    case trailing
  }
}

extension Box.Line: CustomStringConvertible {
  public var description: String {
    return DisplayString {
      body.description
      leading.description
      trailing.description
    }.text
  }
}
