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

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct MetaEnumMacro {
  let parentTypeName: TokenSyntax
  let childCases: [EnumCaseElementSyntax]
  let access: DeclModifierListSyntax.Element?
  let parentParamName: TokenSyntax
  let caseDetection: CaseDetectionMacro
  
  var debugString: String = "None"

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    context: some MacroExpansionContext,
//    includesCaseDetection: Bool
  ) throws {

    guard let enumDecl = decl.as(EnumDeclSyntax.self) else {
      throw DiagnosticsError(diagnostics: [
        CaseMacroDiagnostic.notAnEnum(decl).diagnose(at: Syntax(node))
      ])
    }

    if includesCaseDetection {
      self.caseDetection = try? CaseDetectionMacro(
        node: node,
        decl: decl
      )

    } else {
      self.caseDetection = nil
    }

    self.parentTypeName = enumDecl.name.triviaRemoved(.trailing)
    self.access = enumDecl.modifiers.first(where: \.isPublicAccessLevel)

    self.childCases = enumDecl.caseElements.map { parentCase in
      parentCase.with(\.parameterClause, nil)
    }

    self.parentParamName = context.makeUniqueName("parent")
  }

}

extension MetaEnumMacro {

  func makeMetaEnum() -> [DeclSyntax] {
    let caseDecls =
      childCases
      .map { childCase in
        "  case \(childCase.name)"
      }
      .joined(separator: "\n")

    let caseDetectorIfAvailable: [DeclSyntax]
    if let caseDetection {
      caseDetectorIfAvailable = caseDetection.makeCaseDetector()
    } else {
      caseDetectorIfAvailable = []
    }
    let meta: DeclSyntax = """
      \(access)enum Meta {
      \(raw: caseDecls)
      \(makeMetaInit())
      }
      """
    return [meta] + caseDetectorIfAvailable
  }

  func makeMetaInit() -> DeclSyntax {
    let caseStatements =
      childCases
      .map { childCase in
        """
          case .\(childCase.name):
            self = .\(childCase.name)
        """
      }
      .joined(separator: "\n")

    return """
              // Hello
      \(access)init(_ \(parentParamName): \(parentTypeName)) {
        switch \(parentParamName) {
      \(raw: caseStatements)
        }
      }
      """
  }
}
