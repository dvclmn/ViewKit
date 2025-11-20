//
//  OptionalInitsMacro.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder

/// Generates failable initializers for enum cases with associated values,
/// accepting optional parameters and returning nil if the parameter is nil.
///
/// Usage:
/// ```swift
/// @OptionalCaseInits
/// public enum Attribute {
///   case foreground(NSColor)
///   case font(NSFont)
/// }
/// ```
///
/// Expands to:
/// ```swift
/// public enum Attribute {
///   case foreground(NSColor)
///   case font(NSFont)
///
///   public init?(foreground: NSColor?) {
///     guard let foreground else { return nil }
///     self = .foreground(foreground)
///   }
///
///   public init?(font: NSFont?) {
///     guard let font else { return nil }
///     self = .font(font)
///   }
/// }
/// ```
public struct OptinitsMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
      throw MacroError("@Optinits can only be attached to enum declarations")
    }

    let accessLevel =
      enumDecl.modifiers.first { modifier in
        ["public", "internal", "private", "fileprivate"].contains(
          modifier.name.text
        )
      }?.name.text ?? "internal"

    var initializers: [DeclSyntax] = []

    for member in enumDecl.memberBlock.members {
      guard let caseDecl = member.decl.as(EnumCaseDeclSyntax.self) else {
        continue
      }

      for element in caseDecl.elements {
        guard let parameterClause = element.parameterClause,
          parameterClause.parameters.count == 1,
          let parameter = parameterClause.parameters.first
        else {
          continue
        }

        let caseName = element.name.text
        let paramType = parameter.type.trimmedDescription

        let initializer: DeclSyntax =
          """
          \(raw: accessLevel) init?(\(raw: caseName): \(raw: paramType)?) {
            guard let \(raw: caseName) else { return nil }
            self = .\(raw: caseName)(\(raw: caseName))
          }
          """

        initializers.append(initializer)
      }
    }

    return initializers
  }
}

//enum MacroError: Error, CustomStringConvertible {
//  case notAnEnum
//
//  var description: String {
//    switch self {
//      case .notAnEnum:
//        return "@OptionalCaseInits can only be applied to enums"
//    }
//  }
//}
