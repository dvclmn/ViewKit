//
//  StyledStringConvertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

public protocol StyledStringConvertible {
  //  associatedtype Value: StringConvertible
  //  var value: Value { get }
  func toStyledString() -> StyledString
}




//extension StyledStringConvertible where Self: StringConvertible {
//  public var toString: String {
//    self.toString
//    //    self.toStyledString().styledString.toString
//  }
//}

//extension StyledStringConvertible where Self: StringConvertible {
//  public var value: Value { return self.toString }
//}
//extension String: StyledStringConvertible {
//  public func toDisplayString() -> StyledString {
//    .init(self)
//  }
//}
//
//extension Int: StyledStringConvertible {
//  public func toDisplayString() -> StyledString {
//    .init(self.toString)
//  }
//}
//
//extension Int: StyledStringConvertible {
//  public func toDisplayString() -> StyledString {
//    .init(self.toString)
//  }
//}
