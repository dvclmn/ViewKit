//
//  SequenceBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

// Helper extension to split StyledString by lines while preserving styling

//extension DisplayElement: StyledStringConvertible {
//  public var toStyledString: StyledString {
//    switch self {
//      case .text(let styledString):
//        return styledString
//      case .indented(let title, let indent, let content):
//        return title + indent + content
//    }
//  }
//}

//@resultBuilder
//public struct DisplayStringIndentedBuilder {
//  public static func buildBlock(_ components: [DisplayElement]...) -> [DisplayElement] {
//    components.flatMap { $0 }
//  }
//
//  public static func buildExpression<T: StyledStringConvertible>(_ value: T) -> [DisplayElement] {
//    [.text(value.toStyledString)]
//  }
//
//  public static func buildExpression(_ value: Indented) -> [DisplayElement] {
//    [.indented(title: value.title, indent: value.indentString, content: value.contentElements)]
//  }
//}

public typealias BuilderElement = DisplayElement
//public typealias BuilderElement = StyledString

@resultBuilder
public struct DisplayStringBuilder {

  public static func buildBlock(_ components: [BuilderElement]...) -> [BuilderElement] {
    components.flatMap { $0 }
  }

  public static func buildOptional(_ component: [BuilderElement]?) -> [BuilderElement] {
    component ?? []
  }

  public static func buildEither(first component: [BuilderElement]) -> [BuilderElement] {
    component
  }

  public static func buildEither(second component: [BuilderElement]) -> [BuilderElement] {
    component
  }

  public static func buildArray(_ components: [[BuilderElement]]) -> [BuilderElement] {
    components.flatMap { $0 }
  }
}

// MARK: - buildExpression overloads
extension DisplayStringBuilder {

  /// Allows for using both arrays and single items
  public static func buildExpression(_ expression: [BuilderElement]) -> [BuilderElement] {
    expression
  }

  public static func buildExpression(_ expression: BuilderElement) -> [BuilderElement] {
    [expression]
  }

  /// This handles specific types, anything from `String`
  /// to `AttributedString` to `Indented`
  //  public static func buildExpression<T: StyledStringConvertible>(_ value: T) -> [StyledString] {
  //    [value.toStyledString]
  //  }

  public static func buildExpression<T: StyledStringConvertible>(_ value: T) -> [BuilderElement] {
    if let value = value as? Indented {
      return [.indented(title: value.title, indent: value.indentString, content: value.contentElements)]
    }
    return [.text(value.toStyledString)]
    
  }

//  public static func buildExpression(_ value: Indented) -> [BuilderElement] {
//    [
//      .indented(
//        title: value.title,
//        indent: value.indentString,
//        content: value.contentElements
//      )
//    ]
//  }
  
}
