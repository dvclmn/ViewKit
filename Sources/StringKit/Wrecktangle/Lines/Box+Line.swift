//
//  Box+Line.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box {
  
  /// Curious to see whether I *need* `LineType` to
  /// fully express all the stuff, or whether I can just construct
  /// any Line based on any parts, given a StringStack-based
  /// approach, rather than PartType / String mix
  public struct Line {
    let type: LineType
    let leading: StringStack
    let body: StringStack
    let trailing: StringStack
  }
  
}

extension Box.Line {
  static func create(_ type: Box.LineType) -> Box.Line {
    switch type {
      case .text(let string):
        <#code#>
      case .structure(let structureType):
        <#code#>
    }
  }
  
  
}

