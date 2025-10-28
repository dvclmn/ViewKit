//
//  MetaEnumHelpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct MetaEnumMacro {

  let detectedEnum: Enum

  //  let parentTypeName: TokenSyntax

  let parentParamName: TokenSyntax
  let caseDetection: CaseDetectionMacro

  var debugString: String = "None"

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    context: some MacroExpansionContext,
  ) throws {

    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@MetaEnum can only be attached to enum declarations")
    }
    self.detectedEnum = Enum(enumDecl)

    //    guard let enumDecl = decl.as(EnumDeclSyntax.self) else {
    //      throw DiagnosticsError(diagnostics: [
    //        CaseMacroDiagnostic.notAnEnum(decl).diagnose(at: Syntax(node))
    //      ])
    //    }

    self.caseDetection = try CaseDetectionMacro(
      node: node,
      decl: decl
    )

    //    self.access = enumDecl.modifiers.first(where: \.isPublicAccessLevel)

    self.parentParamName = context.makeUniqueName("parent")
  }

}

extension MetaEnumMacro {

  var parentTypeName: String { detectedEnum.identifier }
  var access: String { detectedEnum.accessLevel?.name ?? "" }
  var childCases: [EnumCase] { detectedEnum.cases }

  //  self.childCases = enumDecl.caseElements.map { parentCase in
  //    parentCase.with(\.parameterClause, nil)
  //  }
  //  var parentTypeName: TokenSyntax { detectedEnum.name.triviaRemoved(.trailing) }

  func makeMetaEnum() -> [DeclSyntax] {
    let caseDecls =
      childCases
      .map { childCase in
        "  case \(childCase.identifier)"
      }
      .joined(separator: "\n")

//    let caseDetectorIfAvailable: [DeclSyntax]
//    if let caseDetection {
//      caseDetectorIfAvailable =
//    } else {
//      caseDetectorIfAvailable = []
//    }
    let meta: DeclSyntax = """
      \(raw: access)enum Meta {
      \(raw: caseDecls)
      \(makeMetaInit())
      }
      """
    return [meta] + caseDetection.makeCaseDetector()
  }

  func makeMetaInit() -> DeclSyntax {
    let caseStatements =
      childCases
      .map { childCase in
        """
          case .\(childCase.identifier):
            self = .\(childCase.identifier)
        """
      }
      .joined(separator: "\n")

    return """
              // Hello
      \(raw: access)init(_ \(parentParamName): \(raw: parentTypeName)) {
        switch \(parentParamName) {
      \(raw: caseStatements)
        }
      }
      """
  }
}
