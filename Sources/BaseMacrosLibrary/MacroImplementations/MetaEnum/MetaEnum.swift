//
//  MetaEnum.swift
//  BaseMacros
//
//  Created by Dave Coleman on 18/9/2025.
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
import MacroToolkit

extension MetaEnumMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {

    let shouldDetectCases: Bool = node.boolArgument(labeled: "includesCaseDetection")

    let macro = try MetaEnumMacro(
      node: node,
      decl: declaration,
      context: context,
      includesCaseDetection: shouldDetectCases
    )
    
    throw MacroError("Detect? \(shouldDetectCases)")

    return macro.makeMetaEnum()
  }
}

enum CaseMacroDiagnostic {
  case notAnEnum(DeclGroupSyntax)
  case noCaseDetect
}

extension CaseMacroDiagnostic: DiagnosticMessage {

  var name: String {
    switch self {
      case .notAnEnum: "notAnEnum"
      case .noCaseDetect: "noCaseDetect"
    }
  }

  var message: String {
    switch self {
      case .notAnEnum(let decl):
        "'@MetaEnum' can only be attached to an enum, not \(decl.descriptiveDeclKind(withArticle: true))"

      case .noCaseDetect: "Didn't detect cases"
    }
  }

  static var domain: String { "MetaEnumDiagnostic" }

  var diagnosticID: MessageID { MessageID(domain: Self.domain, id: name) }

  var severity: DiagnosticSeverity {
    switch self {
      case .notAnEnum: .error
      case .noCaseDetect: .note
    }
  }

  func diagnose(at node: Syntax) -> Diagnostic {
    Diagnostic(node: node, message: self)
  }
}
