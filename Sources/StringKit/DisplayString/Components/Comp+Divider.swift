//
//  Comp+Divider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/11/2025.
//

public struct Divider {
  
//  public let key: String
  public let value: DisplayBlock
  
  public init(value: (any StringConvertible) = "\n----------\n\n") {
    self.value = .text(StyledString(value.toString))
  }
}

extension Divider: StyledStringConvertible {
  public var toStyledString: StyledString {
//    let labelPart = StyledString("\(key)\(separator)", with: .secondary)
//    let valuePart = value?.toStyledString ?? "nil"
//    return labelPart + valuePart
    
    return value.toStyledString
//    return StyledString(value ?? fallback)
    //    return StyledString("\(key)\(separator)\(valuePart)")
    
  }
}
