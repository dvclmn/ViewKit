//
//  Helper+Conformance.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

private enum ConformanceError: Error {
  case alreadyConforms
}

extension MacroHelpers {

  static func createConformanceForEnum(
    decl: EnumDeclSyntax,
    protocol: TypeSyntax
  ) throws -> [ExtensionDeclSyntax] {

    // Avoid generating a duplicate conformance
    guard hasConformance(named: `protocol`, decl: decl) else {
      let conformance = try ExtensionDeclSyntax("extension \(decl.name): \(`protocol`) {}")
//      let conformance = try ExtensionDeclSyntax("nonisolated extension \(decl.name): \(`protocol`) {}")
      return [conformance]
    }
    throw ConformanceError.alreadyConforms

  }

  private static func hasConformance(named name: TypeSyntax, decl: EnumDeclSyntax) -> Bool {
    guard let inheritedTypes = decl.inheritanceClause?.inheritedTypes, !inheritedTypes.isEmpty else {
      return false
    }

    // Helper to normalize a TypeSyntax to its base identifier name (without generics or trivia)
    func baseIdentifier(of type: TypeSyntax) -> String {
      let cleaned = type.withoutTrivia()
      if let simple = cleaned.as(IdentifierTypeSyntax.self) {
        return simple.name.text
      }
      // Fallback to description if not an IdentifierTypeSyntax (covers some composed cases)
      // Trim anything after a '<' to ignore generic arguments when comparing
      let desc = cleaned.description
      if let angleIndex = desc.firstIndex(of: "<") {
        return String(desc[..<angleIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
      }
      return desc.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    let target = baseIdentifier(of: name)

    for inherited in inheritedTypes {
      let inheritedType = inherited.type
      if baseIdentifier(of: TypeSyntax(inheritedType)) == target {
        return true
      }
    }
    return false
  }

  // TODO: Make work for both structs and enum
  /// Create conformance only if needed, otherwise throws
  /// Only supports single protocol, will change this
  //  static func createConformanceForEnum(
  //    decl: EnumDeclSyntax,
  //    conformingTo protocol: TypeSyntax
  //      //    conformingTo protocols: [TypeSyntax]
  //  ) throws -> [ExtensionDeclSyntax] {
  //
  //    //    let conformanceType = "OptionSet"
  //    /// Check for existing conformances
  //    let hasOptionSetConformance = hasConformance(
  //      named: `protocol`,
  //      decl: decl
  //    )
  //
  //    /// If already conforms, then exit early — job done!
  //    guard !hasOptionSetConformance else {
  //      return []
  //    }
  //
  //    /// Otherwise, create the conformance
  //    let conformance = try ExtensionDeclSyntax(
  //      "nonisolated extension \(raw: detectedStruct.identifier): \(raw: conformanceType) {}")
  //
  //    return [conformance]
  //
  //    //    return [try ExtensionDeclSyntax("extension \(type): Identifiable {}")]
  //  }

  //  private static func hasConformance(
  //    named name: TypeSyntax,
  //    decl: EnumDeclSyntax
  //  ) -> Bool {
  //    guard let type = TypeProtocol(decl) else { return false }
  //    guard let inheritedTypes = decl.inheritanceClause?.inheritedTypes else {
  //      return false
  //    }
  //
  //
  //
  //    //    let inheritedTypes: [TypeSyntax] = decl._syntaxNode.trailingTrivia
  ////    for inherited in inheritedTypes where inherited._syntaxNode.withoutTrivia().description == name {
  ////      return true
  ////    }
  ////    return false
  //  }

}
