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

struct SetOfOptionsExtensionBuilder {

  let detectedStruct: Struct

  //  init(
  //    node: AttributeSyntax,
  //    decl: some DeclGroupSyntax,
  //    context: some MacroExpansionContext,
  //  ) throws {
  //
  //    guard let enumDecl = decl as? EnumDeclSyntax else {
  //      throw MacroError("@MetaEnum can only be attached to enum declarations")
  //    }
  //    self.detectedEnum = Enum(enumDecl)
  //
  //    self.caseDetection = try CaseDetectionBuilder(
  //      node: node,
  //      decl: decl
  //    ).build()
  //
  //    self.parentParamName = context.makeUniqueName("parent")
  //  }
  init() throws {

  }
}

extension SetOfOptionsExtensionBuilder {
  func hasConformance(named name: String) -> Bool {
    for inherited in inheritedTypes where inherited.description == name {
      return true
    }
  }

  var inheritedTypes: [Type] {
    detectedStruct.inheritedTypes
  }
}

extension SetOfOptionsExtensionBuilder {
  func build() throws -> [ExtensionDeclSyntax] {
    /// Decode the expansion arguments.
    //    guard
    //      let (structDecl, _, _) = decodeExpansion(
    //        of: node,
    //        attachedTo: declaration,
    //        in: context,
    //        emitDiagnostics: false
    //      )
    //    else { return [] }

    /// Check for existing conformances
//    var hasOptionSet = false
    let conformanceType = "OptionSet"
    let hasOptionSetConformance = hasConformance(named: conformanceType)

    /// If already conforms, then exit early — job done!
    guard !hasOptionSetConformance else {
      return []
    }
    //    if let inheritedTypes = structDecl.inheritanceClause?.inheritedTypes {
    //      for inherited in inheritedTypes {
    //        let typeName = inherited.type.trimmedDescription
    //        if typeName == "OptionSet" {
    //          hasOptionSet = true
    //        }
    //      }
    //    }

    /// Build conformance list based on what's missing
//    var conformances: [String] = []
//    if !hasOptionSetConformance {
//      conformances.append("OptionSet")
//    }

    /// If all conformances are already present, don't add an extension
    guard !conformances.isEmpty else {
      return []
    }

    /// Create extension with only the missing conformances
//    let conformanceList = conformances.joined(separator: ", ")

    let conformance = ExtensionDeclSyntax("nonisolated extension \(type): \(raw: conformanceList) {}")
    
    let thing = [
      try
    ]

    return thing
  }
}
