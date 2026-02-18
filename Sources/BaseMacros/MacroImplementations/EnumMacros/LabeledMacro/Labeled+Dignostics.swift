//
//  Labeled+Dignostics.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

enum LabeledDiagnostic {
  struct MissingStringRawType: DiagnosticMessage {
    let message: String = "@Labeled requires the enum to declare a String raw type."
    let diagnosticID: MessageID = .init(domain: "Labeled", id: "missing_string_raw_type")
    let severity: DiagnosticSeverity = .error
  }
}

enum LabeledFixIt {
  struct AddStringRawType: FixItMessage {
    let message: String = "Add ': String' to this enum"
    let fixItID: MessageID = .init(domain: "Labeled", id: "add_string_raw_type")
  }
}

extension LabeledHelpers {
  static func makeEnumWithStringRawType(_ enumDecl: EnumDeclSyntax) -> EnumDeclSyntax {
    // Build the `String` inherited type node
    let stringType = InheritedTypeSyntax(
      type: TypeSyntax(IdentifierTypeSyntax(name: .identifier("String"))),
      trailingComma: enumDecl.inheritanceClause?.inheritedTypes.isEmpty == false
        ? .commaToken(trailingTrivia: .space)
        : nil
    )

    guard let clause = enumDecl.inheritanceClause else {
      // Create a new inheritance clause: `: String`
      let colon = TokenSyntax.colonToken(trailingTrivia: .space)
      let list = InheritedTypeListSyntax([stringType])
      let newClause = InheritanceClauseSyntax(
        colon: colon,
        inheritedTypes: list
      )
      return enumDecl.with(\.inheritanceClause, newClause)
    }
    // Insert `String` at the beginning of the inherited types (raw type must come first)
    var types = clause.inheritedTypes
    // Ensure spacing/trivia is nice for the new first element
    let updatedTypes =
      types.isEmpty
      ? InheritedTypeListSyntax([stringType])
      : InheritedTypeListSyntax([stringType] + types)
    let updatedClause = clause.with(\.inheritedTypes, updatedTypes)
    return enumDecl.with(\.inheritanceClause, updatedClause)
  }
}

extension LabeledHelpers {
  static func diagnoseMissingStringRawType(
    enumDecl: EnumDeclSyntax,
    context: some MacroExpansionContext
  ) {
    let newEnum = makeEnumWithStringRawType(enumDecl)

    let diagnostic = Diagnostic(
      node: Syntax(enumDecl.identifier),  // anchor on the name
      message: LabeledDiagnostic.MissingStringRawType(),
      fixIts: [
        FixIt(
          message: LabeledFixIt.AddStringRawType(),
          changes: [
            .replace(oldNode: Syntax(enumDecl), newNode: Syntax(newEnum))
          ]
        )
      ]
    )

    context.diagnose(diagnostic)
  }
}
