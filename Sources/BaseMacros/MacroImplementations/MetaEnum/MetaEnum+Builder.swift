//
//  MetaEnumCase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/1/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct MetaEnumBuilder {
  let detectedEnum: Enum
  let parentParamName: TokenSyntax
  let caseDetection: CaseDetectionMacro

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    context: some MacroExpansionContext,
  ) throws {

    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@MetaEnum can only be attached to enum declarations")
    }
    self.detectedEnum = Enum(enumDecl)

    self.caseDetection = try CaseDetectionMacro(
      node: node,
      decl: decl
    )

    self.parentParamName = context.makeUniqueName("parent")
  }
}

extension MetaEnumBuilder {
  var parentTypeName: String { detectedEnum.identifier }
  var access: String { detectedEnum.accessLevel?.name ?? "" }
  var childCases: [MetaEnumCase] { detectedEnum.cases.map(MetaEnumCase.init) }
  
  func casesList(_ valueForCase: (MetaEnumCase) -> String) -> String {
    childCases
      .map { "case .\($0.name): \(valueForCase($0))" }
      .joined(separator: "\n")
    //    return DeclSyntax(stringLiteral: cases)
  }
//  var childCases: [EnumCase] { detectedEnum.cases }
}
