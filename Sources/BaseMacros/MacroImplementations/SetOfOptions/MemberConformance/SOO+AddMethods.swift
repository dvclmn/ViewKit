//
//  SOO+AddMethods.swift
//  BaseMacros
//
//  Created by Dave Coleman on 18/9/2025.
//

import BasePrimitives
import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension SetOfOptionsBuilder {

  //  private static let isUsingBuilderForOutput: Bool = false

  //  public static func expansion(
  //    of attribute: AttributeSyntax,
  //    providingMembersOf decl: some DeclGroupSyntax,
  //    conformingTo: [TypeSyntax],
  //    in context: some MacroExpansionContext
  //  ) throws -> [DeclSyntax] {

  //  }

  private static func output(
    enum optionsEnum: EnumDeclSyntax,
    elements caseElements: [EnumCaseElementSyntax],
    access: DeclModifierListSyntax.Element?,
    rawType: TypeSyntax
  ) -> [DeclSyntax] {

    let trimmedCases: [String] = caseElements.map { $0.name.text }

    // MARK: - Raw Value methods
//    let primary: [DeclSyntax] = [
//      "\(access)let rawValue: \(rawType)",
//      "\(access)init(rawValue: \(rawType)) { self.rawValue = rawValue }",
//    ]

    // MARK: - Option Set static members
    let staticVars = trimmedCases.map { (element) -> DeclSyntax in
      "\(access)static let \(raw: element): Self = Self(rawValue: 1 << \(optionsEnum.name).\(raw: element).rawValue)"
    }

    // MARK: - String Value
    let snakeConditional: String = "isSnakeCase"

    let stringSwitchCases = caseElements.map { element in
      let camel = element.name.text
      let snake = camel.camelCaseToSnakeCase

      /// If both versions are identical, just return the raw string
      guard camel == snake else {
        /// Otherwise, provide the ternary conditional
        return "  case .\(camel): \(snakeConditional) ? \"\(snake)\" : \"\(camel)\""
      }
      return "  case .\(camel): \"\(camel)\""
    }.joined(separator: "\n    ")

    let optionSetStringBuilder: String = trimmedCases.map { element in
      """
      if self.contains(.\(element)) {
        strings.append(Self.stringValue(for: \(optionsEnum.name).\(element), \(snakeConditional): \(snakeConditional)))
      }
      """
    }.joined(separator: "\n  ")

    /// Example of `OptionSet` `.all`:
    ///
    /// ```swift
    /// public static let first = Self(rawValue: 1 << 0)
    /// public static let second = Self(rawValue: 1 << 1)
    /// public static let third = Self(rawValue: 1 << 2)
    ///
    /// public static let all: Self = [
    ///   .first,
    ///   .second,
    ///   .third,
    /// ]
    /// ```

    let allCasesList = trimmedCases.map { ".\($0)" }.joined(separator: ",\n  ")

    let extraDecls: [DeclSyntax] = [
      /// OptionSet `.all` added here
      """
        \(access)static let all: Self = [
          \(raw: allCasesList)
        ]
      """,
      """
      \(access)static func stringValue(
        for option: \(optionsEnum.name), 
        \(raw: snakeConditional): Bool = false
      ) -> String {
        switch option {
            \(raw: stringSwitchCases)
        } 
      }
      """,

      """
      \(access)func stringValueJoined(isSnakeCase: Bool = false) -> String {
        var strings: [String] = []
        \(raw: optionSetStringBuilder)
        return strings.joined(separator: ", ")
      }
      """,
    ]

    return primary + staticVars + extraDecls
  }
}
