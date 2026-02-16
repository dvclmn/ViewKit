//
//  CaseDetectHelpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CaseDetectionBuilder {
  let detectedEnum: Enum
  let includesNames: Bool

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
  ) throws {
    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@CaseDetection can only be attached to enum declarations")
    }
    self.detectedEnum = Enum(enumDecl)
    let shouldIncludeNames = node.boolArgument(labeled: "includesNames")

    self.includesNames = shouldIncludeNames
  }
}

extension CaseDetectionBuilder {

  private var cases: [EnumCase] { detectedEnum.cases }
  private var access: String { detectedEnum.accessLevel?.name ?? "" }

  func build() -> [DeclSyntax] {

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

    guard includesNames else {
      return detections
    }
    return detections + [buildNames()]

  }

  func buildNames() -> DeclSyntax {

    let casesString: String = cases.reduce("") { partialResult, item in
      partialResult + "case .\(item.identifier): \"\(item.identifier.initialUppercased)\"\n"
    }

    let refName: DeclSyntax = """
      \(raw: access) var referenceName: String {
        switch self {
          \(raw: casesString)
        }
      }

      """

    return refName
  }

}
