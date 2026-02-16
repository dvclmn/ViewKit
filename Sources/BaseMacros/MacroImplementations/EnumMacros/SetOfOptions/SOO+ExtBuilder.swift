//
//  SOO+ExtBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// The builder that handles adding `OptionSet` conformance to the main struct
struct SetOfOptionsExtensionBuilder {

  let detectedStruct: Struct

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
  ) throws {

    guard let structDecl = decl as? StructDeclSyntax else {
      throw MacroError("@SetOfOptions can only be attached to struct declarations")
    }
    self.detectedStruct = Struct(structDecl)
  }
}

extension SetOfOptionsExtensionBuilder {
  func hasConformance(named name: String) -> Bool {
    for inherited in inheritedTypes where inherited.description == name {
      return true
    }
    return false
  }

  var inheritedTypes: [Type] {
    detectedStruct.inheritedTypes
  }
}

extension SetOfOptionsExtensionBuilder {
  func build() throws -> [ExtensionDeclSyntax] {

    let conformanceType = "OptionSet"
    /// Check for existing conformances
    let hasOptionSetConformance = hasConformance(named: conformanceType)

    /// If already conforms, then exit early — job done!
    guard !hasOptionSetConformance else {
      return []
    }

    /// Otherwise, create the conformance
    let conformance = try ExtensionDeclSyntax(
      "nonisolated extension \(raw: detectedStruct.identifier): \(raw: conformanceType) {}")

    return [conformance]
  }
}
