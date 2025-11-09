//
//  Box+Line.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box {

  /// This is strictly a Three-Part Line. Will need to introduce
  /// a new type/system to support e.g. multi-column Boxes
  public struct Line {

    #warning("Consider whether engine in here makes sense, should probably be owned / passed in via function sig?")
    let engine: Box.Engine

    let leading: PartType
    let body: LineType
    let trailing: PartType

    /// Init for Text Line
    public init(
      _ textContent: String,
      leading: PartType,
      trailing: PartType,
      using engine: Box.Engine
    ) {
      self.leading = leading
      self.body = .text(textContent)
      self.trailing = trailing
      self.engine = engine
    }

    /// Init for Structure Line
    public init(
      _ repeater: PartType,
      leading: PartType,
      trailing: PartType,
      using engine: Box.Engine
    ) {
      self.leading = leading
      self.body = .repeater(repeater)
      self.trailing = trailing
      self.engine = engine
    }
  }

  enum LinePart {
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
    }.plainText
  }
}
