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
extension Divider: DisplayRenderable{
  func render(using format: DisplayFormat) -> String {
    value.render(using: format)
  }
}

extension Divider: StringRenderable {
  public var toString: String {
    render(using: .default)
    //    let labelPart = StyledString("\(key)\(separator)", with: .secondary)
    //    let valuePart = value?.toStyledString ?? "nil"
    //    return labelPart + valuePart

//    return value.toString ?? ""
    //    return StyledString(value ?? fallback)
    //    return StyledString("\(key)\(separator)\(valuePart)")

  }
}
