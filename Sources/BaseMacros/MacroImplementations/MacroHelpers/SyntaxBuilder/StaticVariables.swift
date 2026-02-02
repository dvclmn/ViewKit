//
//  StaticVariables.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/10/2025.
//

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import BasePrimitives

extension Array where Element == EnumCaseElementSyntax {
  func staticOptionSetVariables(
    for enumName: TokenSyntax,
    access: DeclModifierSyntax?
  ) -> [DeclSyntax] {
    self.map { element in
      """
      \(access)static let \(element.name): Self = Self(rawValue: 1 << \(enumName).\(element.name).rawValue)
      """
    }
  }

  func allCasesList() -> String {
    self.map { ".\($0.name)" }.joined(separator: ",\n  ")
  }

  func stringSwitchCases(snakeConditional: String) -> String {
    self.map { enumCase in
      let camel = enumCase.name.text
      let snake = camel.camelCaseToSnakeCase
      return "  case .\(enumCase.name): \(snakeConditional) ? \"\(snake)\" : \"\(camel)\""
    }.joined(separator: "\n  ")
  }

  func optionSetStringBuilder(
    enumName: TokenSyntax,
    snakeConditional: String
  ) -> String {
    self.map { element in
      """
      if self.contains(.\(element.name)) {
        strings.append(Self.stringValue(for: \(enumName).\(element.name), \(snakeConditional): \(snakeConditional)))
      }
      """
    }.joined(separator: "\n  ")
  }
}

extension String {
  public var toDeclSyntax: DeclSyntax {
    DeclSyntax(stringLiteral: self)
  }
}

//extension String {
//  var camelToSnake: String {
//    var result = ""
//    for (index, ch) in self.enumerated() {
//      if ch.isUppercase {
//        if index > 0 { result.append("_") }
//        result.append(ch.lowercased())
//      } else {
//        result.append(ch)
//      }
//    }
//    return result
//  }
//}
