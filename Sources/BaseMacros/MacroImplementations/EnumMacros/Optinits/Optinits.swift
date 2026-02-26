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
/// See `BaseMacrosClient/main` for usage example.
public struct OptinitsMacro: MemberMacro {
  
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
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
      generateInitializers(
        elements: caseDecl.elements,
        accessLevel: accessLevel,
        inits: &initializers
      )
    }
    
    return initializers
  }
  
//  public static func expansion(
//    of node: AttributeSyntax,
//    providingMembersOf declaration: some DeclGroupSyntax,
//    in context: some MacroExpansionContext
//  ) throws -> [DeclSyntax] {
//    
//  }
  
  private static func generateInitializers(
    elements: EnumCaseElementListSyntax,
    accessLevel: String,
    inits: inout [DeclSyntax]
  ) {
    for element in elements {
      guard let parameters = element.parameterClause?.parameters,
            !parameters.isEmpty
      else {
        // Skip enum cases with no associated values
        continue
      }

      let caseName = element.name.text
      
      // Build parameter labels: first is "{caseName}Optional", rest are parameter labels or alphabet letters
      var paramLabels: [String] = []
//      let isSingleValue = parameters.count == 1
      
      for (index, param) in parameters.enumerated() {
        if index == 0 {
          // First parameter label is caseName + "Optional"
          paramLabels.append("\(caseName)Optional")
        } else {
          // For others, use label if present, else alphabet letter
          if let label = param.firstName?.text, !label.isEmpty {
            paramLabels.append(label)
          } else {
            let letter = Character.letter(for: index) ?? "a"
            paramLabels.append(String(letter))
          }
        }
      }

      // Build parameter types (trimmed description)
      let paramTypes = parameters.map { $0.type.trimmedDescription }
      
      // Construct initializer parameter list as "label: Type?"
      let initParams = zip(paramLabels, paramTypes).map { label, type in
        "\(label): \(type)?"
      }.joined(separator: ", ")
      
      // Build guard let unwrapping all parameters
      let guardLets = paramLabels.map { label in
        "guard let \(label) else { return nil }"
      }.joined(separator: "\n    ")
      
      // Build self assignment with parameter labels if present
      let selfAssignmentParams = zip(parameters, paramLabels).map { param, label in
        if let name = param.firstName, name.text != "_" && !name.text.isEmpty {
          return "\(name.text): \(label)"
        } else {
          return label
        }
      }.joined(separator: ", ")
      
      let initializer: DeclSyntax =
        """
        \(raw: accessLevel) init?(\(raw: initParams)) {
          \(raw: guardLets)
          self = .\(raw: caseName)(\(raw: selfAssignmentParams))
        }
        """
      
      inits.append(initializer)
    }
  }
}

private extension Character {
  /// Returns a letter for an index starting at 0 -> 'a', 1 -> 'b', etc.
  static func letter(for index: Int) -> Character? {
    guard index >= 0 && index < 26 else { return nil }
    return Character(UnicodeScalar(index + 97)!)
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

