//
//  SOO+Builder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/10/2025.
//

//import SwiftDiagnostics
//import SwiftSyntax
//import SwiftSyntaxBuilder
//import SwiftSyntaxMacros
//
//extension SetOfOptionsMacro {
//  @DeclSyntaxBuilder
//  static func buildOptionSetMembers(
//    caseElements: [EnumCaseElementSyntax],
//    enumName: TokenSyntax,
//    rawType: TypeSyntax,
//    access: DeclModifierSyntax?
//  ) -> [DeclSyntax] {
//    // Core OptionSet requirements
//    "\(access)typealias RawValue = \(rawType)"
//    "\(access)var rawValue: RawValue"
//    "\(access)init() { self.rawValue = 0 }"
//    "\(access)init(rawValue: RawValue) { self.rawValue = rawValue }"
//
//    // Static variables for each case
//    caseElements.staticOptionSetVariables(for: enumName, access: access)
//
//    // Additional computed properties and methods
//    buildHelperMethods(
//      caseElements: caseElements,
//      enumName: enumName,
//      access: access
//    )
//  }

//  @DeclSyntaxBuilder
//  static func buildHelperMethods(
//    caseElements: [EnumCaseElementSyntax],
//    enumName: TokenSyntax,
//    access: DeclModifierSyntax?
//  ) -> [DeclSyntax] {
//    let snakeConditional = "isSnakeCase"
//    let allCasesList = caseElements.allCasesList()
//    let stringSwitchCases = caseElements.stringSwitchCases(snakeConditional: snakeConditional)
//    let optionSetStringBuilder = caseElements.optionSetStringBuilder(
//      enumName: enumName,
//      snakeConditional: snakeConditional
//    )
//
//    // `.all` static property
//    """
//    \(access)static let all: Self = [
//      \(raw: allCasesList)
//    ]
//    """
//
//    // String value conversion for individual options
//    """
//    \(access)static func stringValue(
//      for option: \(enumName), 
//      \(raw: snakeConditional): Bool = false
//    ) -> String {
//      switch option {
//        \(raw: stringSwitchCases)
//      } 
//    }
//    """
//
//    // Joined string representation
//    """
//    \(access)func stringValueJoined(isSnakeCase: Bool = false) -> String {
//      var strings: [String] = []
//      \(raw: optionSetStringBuilder)
//      return strings.joined(separator: ", ")
//    }
//    """
//  }
//}
