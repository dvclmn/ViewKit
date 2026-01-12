//
//  Comp+Divider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/11/2025.
//

public struct Divider {

  //  public let key: String
  public let value: DisplayBlock

  public init(value: String = "----------\n") {
    self.value = .text(value)
  }
}

extension Divider: StringConvertible {
  public var toString: String {
    //    let labelPart = StyledString("\(key)\(separator)", with: .secondary)
    //    let valuePart = value?.toStyledString ?? "nil"
    //    return labelPart + valuePart

    return value.toString ?? ""
    //    return StyledString(value ?? fallback)
    //    return StyledString("\(key)\(separator)\(valuePart)")

  }
}
