//
//  Labeled+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntaxBuilder
import SwiftSyntax
import SwiftSyntaxMacros

enum LabeledHelpers {
  static func detectEnum(
    in decl: DeclGroupSyntax,
    context: some MacroExpansionContext,
    offerFixIt: Bool = true
  ) throws -> Enum {
    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@Labeled can only be attached to enum declarations")
    }

    let inheritedTypeNames: [String] =
      enumDecl.inheritanceClause?.inheritedTypes.compactMap {
        $0.type.trimmedDescription
      } ?? []

    let hasStringRawType = inheritedTypeNames.contains { $0 == "String" || $0 == "Swift.String" }

    if !hasStringRawType {
      if offerFixIt {
        diagnoseMissingStringRawType(enumDecl: enumDecl, context: context)
      }
      /// Still throw to stop expansion; the fix-it lets the user apply the change
      throw MacroError(
        "@Labeled requires the enum to declare a String raw type, e.g. `enum MyEnum: String { ... }`."
      )
    }

    // Optional: check RawRepresentable if you want explicit conformance too
    return Enum(enumDecl)
  }
}
