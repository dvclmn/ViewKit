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
      // Still throw to stop expansion; the fix-it lets the user apply the change
      throw MacroError(
        "@Labeled requires the enum to declare a String raw type, e.g. `enum MyEnum: String { ... }`."
      )
    }

    // Optional: check RawRepresentable if you want explicit conformance too
    return Enum(enumDecl)
  }
  //    // Ensure the attribute is attached to an enum declaration
  //    guard let enumDecl = decl as? EnumDeclSyntax else {
  //      throw MacroError("@Labeled can only be attached to enum declarations")
  //    }
  //
  //    // Collect inherited type names from the enum's inheritance clause
  //    let inheritedTypeNames: [String] = enumDecl.inheritanceClause?.inheritedTypes.compactMap { inherited in
  //      inherited.type.trimmedDescription
  //    } ?? []
  //
  //    // Check for a String raw type (either `String` or fully qualified `Swift.String`)
  //    let hasStringRawType = inheritedTypeNames.contains { $0 == "String" || $0 == "Swift.String" }
  //
  //    // Check for explicit RawRepresentable conformance (explicit or fully qualified)
  //    let explicitlyConformsToRawRepresentable = inheritedTypeNames.contains {
  //      $0 == "RawRepresentable" || $0 == "Swift.RawRepresentable"
  //    }
  //
  //    // Requirement (a): must declare a String raw type
  //    guard hasStringRawType else {
  //      throw MacroError(
  //        "@Labeled requires the enum to declare a String raw type, e.g. `enum MyEnum: String { ... }`.")
  //    }
  //
  //    // Requirement (b): RawRepresentable conformance is implied for raw-type enums.
  //    // Still, allow explicit conformance if present.
  //    let conformsToRawRepresentable = hasStringRawType || explicitlyConformsToRawRepresentable
  //    guard conformsToRawRepresentable else {
  //      throw MacroError("@Labeled requires the enum to conform to RawRepresentable.")
  //    }
  //
  //    // Return the MacroToolkit convenience wrapper
  //    return Enum(enumDecl)
  //  }
}
