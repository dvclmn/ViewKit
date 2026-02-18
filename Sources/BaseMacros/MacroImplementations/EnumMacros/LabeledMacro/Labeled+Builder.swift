//
//  Labeled+Builder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct LabeledBuilder {
  let detectedEnum: Enum

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    context: some MacroExpansionContext
  ) throws {

    // Ensure the attribute is attached to an enum declaration
    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@Labeled can only be attached to enum declarations")
    }

    // Collect inherited type names from the enum's inheritance clause
    let inheritedTypeNames: [String] = enumDecl.inheritanceClause?.inheritedTypes.compactMap { inherited in
      // Use the trimmed description of the type as a simple textual match
      inherited.type.trimmedDescription
    } ?? []

    // Check for a String raw type (either `String` or fully qualified `Swift.String`)
    let hasStringRawType = inheritedTypeNames.contains { $0 == "String" || $0 == "Swift.String" }

    // Check for explicit RawRepresentable conformance (explicit or fully qualified)
    let explicitlyConformsToRawRepresentable = inheritedTypeNames.contains { $0 == "RawRepresentable" || $0 == "Swift.RawRepresentable" }

    // Requirement (a): must declare a String raw type
    guard hasStringRawType else {
      throw MacroError("@Labeled requires the enum to declare a String raw type, e.g. `enum MyEnum: String { ... }`.")
    }

    // Requirement (b): RawRepresentable conformance is implied for raw-type enums.
    // Still, allow explicit conformance if present.
    let conformsToRawRepresentable = hasStringRawType || explicitlyConformsToRawRepresentable
    guard conformsToRawRepresentable else {
      throw MacroError("@Labeled requires the enum to conform to RawRepresentable.")
    }

    // Stash the detected enum using MacroToolkit's convenience wrapper
    self.detectedEnum = Enum(enumDecl)
  }
}
