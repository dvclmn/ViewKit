//
//  SOO+StructBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct SetOfOptionsBuilder {
  let detectedOptionsEnum: Enum
  let rawType: TypeSyntax

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    conformingTo: [TypeSyntax],
    context: some MacroExpansionContext,
  ) throws {

    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@SetOfOptions requires nested enum")
    }

    guard enumDecl.name.text == "Options" else {
      /// Consider making this configurable one day
      throw MacroError("@SetOfOptions requires nested enum named 'Options'")
    }

    self.detectedOptionsEnum = Enum(enumDecl)

    guard let raw = Self.getRawType(from: node) else {
      throw MacroError("@SetOfOptions requires nested Options enum has a valid raw type")
    }
    self.rawType = raw

  }
}

extension SetOfOptionsBuilder {
  private static func getRawType(from attribute: AttributeSyntax) -> TypeSyntax? {
    let args = attribute.attributeName.as(IdentifierTypeSyntax.self)?.genericArgumentClause
    let rawType = args?.arguments.first?.argument
    return rawType
  }

  func rawValueMethods() -> [DeclSyntax] {
    let items: [DeclSyntax] = [

      "\(raw: detectedOptionsEnum.access)let rawValue: \(rawType)",
      "\(raw: detectedOptionsEnum.access)init(rawValue: \(rawType)) { self.rawValue = rawValue }",
    ]
    return items
  }

  package static func decodeExpansion(
    of attribute: AttributeSyntax,
    attachedTo decl: some DeclGroupSyntax,
    in context: some MacroExpansionContext,
    emitDiagnostics: Bool
  ) -> StructDeclSyntax? {
    //  ) -> (StructDeclSyntax, EnumDeclSyntax, TypeSyntax)? {

    /// Determine the name of the options enum.
    let optionsEnumName: String
    if case .argumentList(let arguments) = attribute.arguments,
      let optionEnumNameArg = arguments.first(labeled: optionsEnumNameArgumentLabel)
    {
      /// We have a options name; make sure it is a string literal.
      guard let stringLiteral = optionEnumNameArg.expression.as(StringLiteralExprSyntax.self),
        stringLiteral.segments.count == 1,
        case .stringSegment(let optionsEnumNameString)? = stringLiteral.segments.first
      else {
        if emitDiagnostics {
          context.diagnose(
            SetOfOptionsMacroDiagnostic.requiresStringLiteral(optionsEnumNameArgumentLabel).diagnose(
              at: optionEnumNameArg.expression
            )
          )
        }
        return nil
      }

      optionsEnumName = optionsEnumNameString.content.text
    } else {
      optionsEnumName = defaultOptionsEnumName
    }

    /// Only apply to structs.
    guard let structDecl = decl.as(StructDeclSyntax.self) else {
      if emitDiagnostics {
        context.diagnose(SetOfOptionsMacroDiagnostic.requiresStruct.diagnose(at: decl))
      }
      return nil
    }

    /// Find the option enum within the struct.
    let members = decl.memberBlock.members.compactMap({ member in
      if let enumDecl = member.decl.as(EnumDeclSyntax.self),
        enumDecl.name.text == optionsEnumName
      {
        return enumDecl
      }
      return nil
    })

    guard let optionsEnum = members.first
    else {
      if emitDiagnostics {
        let diagnostic = SetOfOptionsMacroDiagnostic.requiresOptionsEnum(optionsEnumName)
        context.diagnose(diagnostic.diagnose(at: decl))
      }
      return nil
    }

    /// Retrieve the raw type from the attribute.
    //    guard let genericArgs = attribute.attributeName.as(IdentifierTypeSyntax.self)?.genericArgumentClause,
    //          let rawType = genericArgs.arguments.first?.argument
    //    else {
    //      if emitDiagnostics {
    //        context.diagnose(SetOfOptionsMacroDiagnostic.requiresOptionsEnumRawType.diagnose(at: attribute))
    //      }
    //      return nil
    //    }

    return (structDecl, optionsEnum, rawType)
  }
}

/// This was previously in `expansion(of:providingMembersOf:conformingTo:in:)`
//  package func something() {
//    guard
//      let (_, optionsEnum, rawType) = decodeExpansion(
//        of: attribute,
//        attachedTo: decl,
//        in: context,
//        emitDiagnostics: true
//      )
//    else { return [] }

/// Extract case elements
//    let caseElements: [EnumCaseElementSyntax] = optionsEnum.memberBlock.members.flatMap { member in
//      guard let caseDecl = member.decl.as(EnumCaseDeclSyntax.self) else {
//        return [EnumCaseElementSyntax]()
//      }
//      return Array(caseDecl.elements)
//    }

/// Get access control modifier
//    let access = decl.modifiers.first(where: \.isPublicAccessLevel)

//    guard isUsingBuilderForOutput else {
//    return output(
//      enum: optionsEnum,
//      elements: caseElements,
//      access: access,
//      rawType: rawType
//    )
//    }
/// Using the Builder style for output
//    return buildOptionSetMembers(
//      caseElements: caseElements,
//      enumName: optionsEnum.name,
//      rawType: rawType,
//      access: access
//    )

//  }

//}
