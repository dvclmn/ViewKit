//
//  CaseDetection.swift
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

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxMacros

// Obtained from Swift example macros
// https://github.com/swiftlang/swift-syntax/blob/main/Examples/Sources/MacroExamples/Implementation/Member/CaseDetectionMacro.swift
// Additional modifications based on stackotter's MacroToolkit

public enum CaseDetectionMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf decl: some DeclGroupSyntax,
    conformingTo: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {

    guard let detectedEnum = Enum(decl) else {
      throw MacroError("@CaseDetection can only be attached to enum declarations")
    }

    let access = detectedEnum.accessLevel?.name ?? ""
    //    let thing = node.

    let argument = MacroAttribute(node).argument(labeled: "includesNames")?.asBooleanLiteral
    let isShowingNames: Bool = argument?.value ?? false

    //    SimpleDiagnosticMessage(
    //      message: arguments.debugDescription,
    //      diagnosticID: MessageID(domain: "casedetection", id: "something"),
    //      severity: <#T##DiagnosticSeverity#>
    //    )

    //    guard
    //      let ((nil, nameExpr), (nil, ageExpr)) = destructure(attribute.arguments),
    //      let name = nameExpr.asStringLiteral?.value,
    //      let age = ageExpr.asIntegerLiteral?.value
    //    else {
    //      throw MacroError("Usage: @MyMacro(\"stackotter\", 105)")
    //    }
    let cases: [EnumCase] = detectedEnum.cases
    let detections: [DeclSyntax] =
      cases
      .map { ($0.identifier, $0.identifier.initialUppercased) }
      .map { original, uppercased in
        """
        \(raw: access) var is\(raw: uppercased): Bool {
          if case .\(raw: original) = self {
            return true
          }
          return false
        }
        """
      }

    if isShowingNames {

      let casesString: String = cases.reduce("") { partialResult, item in
        partialResult + "case .\(item.identifier): \"\(item.identifier.initialUppercased)\"\n"
      }
//      let caseStrings: String = cases.map { item in
//        "case .\(item.identifier): \"\(item.identifier.initialUppercased)\""
//      }.joinedLines()

      let refName: DeclSyntax = """
        \(raw: access) var referenceName: String {
          switch self {
            \(raw: casesString)
          }
        }

        """
      let result = detections + [refName]
      return result
    }

    return detections

  }
}
